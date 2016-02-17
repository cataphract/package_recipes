#!/usr/bin/env node

const nconf = require('nconf'),
    nconf_yaml = require('nconf-yaml'),
    fs = require('fs'),
    tls = require('tls'),
    util = require('util'),
    EventEmitter = require('events'),
    childProcess = require('child_process'),
    ipaddr = require('ipaddr.js')

const DEFAULT_CONFIG_FILE          = '/etc/oracle-launcher/config.yaml'
const DEFAULT_SERVER_PORT          = 55397
const DEFAULT_CONTAINER_PORT_START = DEFAULT_SERVER_PORT + 1
const DEFAULT_MAX_CONTAINERS       = 6
const DEFAULT_TIMEOUT              = 7200 * 1000
const DEFAULT_READY_TIMEOUT        = 30 * 1000
const DEFAULT_DOCKER_IMAGE         = 'docker-hub.thehyve.net/oracle-12c'
const DEFAULT_IPTABLES_CHAIN       = 'oracle'

const DOCKER_EXEC = '/usr/bin/docker'
const IPTABLES_EXEC = '/sbin/iptables'

nconf.argv().env().file({ file: DEFAULT_CONFIG_FILE, format: nconf_yaml })
nconf.defaults({
    serverPort:    DEFAULT_SERVER_PORT,
    contPortStart: DEFAULT_CONTAINER_PORT_START,
    dockerImage:   DEFAULT_DOCKER_IMAGE,
    maxContainers: DEFAULT_MAX_CONTAINERS,
    timeout:       DEFAULT_TIMEOUT,
    readyTimeout:  DEFAULT_READY_TIMEOUT,
    iptablesChain: DEFAULT_IPTABLES_CHAIN
})

if (nconf.get('privateKey') == undefined) {
    console.log('Private key not defined')
    process.exit(1)
}
if (nconf.get('certificate') == undefined) {
    console.log('Certificate defined')
    process.exit(1)
}
if (nconf.get('secret') == undefined) {
    console.log('The secret has not been provided')
    process.exit(1)
}

var pool = (function() {
    var allPorts
    var availablePorts

    allPorts = Array.apply(null, Array(nconf.get('maxContainers')))
        .map(function (_, i) { return nconf.get('contPortStart') + i })
    console.log("Available ports: ", allPorts)
    availablePorts = new Set(allPorts)

    return {
        possibleContainerNames: function pool_possibleContainerNames() {
            return allPorts.map(function(elem) { return 'oracle_' + elem })
        },
        retrieve: function pool_retrieve() {
            var port = availablePorts.entries().next().value[0]
            availablePorts.delete(port)
            return port
        },
        returnPort: function pool_return(port) {
            availablePorts.add(port)
        }
    }
})()

var Client = (function() {
    /* events: close */

    /* statics */
    var n = 1
    var currentContainers = 0

    function Client(socket) {
        this.socket = socket
        this.iptablesParams = null

        this.n = n++
        this.log('Creating client for connection from %s:%d',
            socket.remoteAddress, socket.remotePort)
        this.state = Client.STATES.WAITING_FOR_SECRET
        this.container = null
        this.port = null
    }
    util.inherits(Client, EventEmitter)

    var setState = function Client_setState(newState) {
        this.log("Changing state %s -> %s", this.state, newState)
        this.state = newState
    }

    // state transitions go down in the list
    // CONFIGURING_CONTAINER can either transition from
    // CONFIGURING_CONTAINER_THEN_DESTROY or SERVING_CONTAINER
    Client.STATES = {
        WAITING_FOR_SECRET: 'waiting_for_secret',
        CONFIGURING_CONTAINER: 'configuring_container',
        CONFIGURING_CONTAINER_THEN_DESTROY: 'configuring_container_then_destroy',
        SERVING_CONTAINER: 'serving_container',
        DESTROYING_CONTAINER: 'destroying_container',
        DEAD: 'dead',
    }

    function errorClient(message) {
        if (this.socket == null) {
            this.log('Not sending mesage %s because client is already disconnected', message)
            return
        }
        this.log('Closing the connection and sending message: %s', message)
        this.socket.write(message + "\n", 'utf8', function() {
            this.socket.destroy()
        }.bind(this))
        if (this.isStoppable()) {
            this.stopContainer()
        }
    }

    function Client_handleSocketClose(had_error) {
        this.log("Closing socket (had_error: %s)", had_error)
        switch (this.state) {
            case Client.STATES.WAITING_FOR_SECRET:
                this.emit('close') // no resources left
                break
            case Client.STATES.CONFIGURING_CONTAINER:
                setState.call(this, Client.STATES.CONFIGURING_CONTAINER_THEN_DESTROY)
                this.socket = null
                break
            case Client.STATES.CONFIGURING_CONTAINER_THEN_DESTROY:
            case Client.STATES.DESTROYING_CONTAINER:
                this.log("Close in %s", this.state)
                break
            case Client.STATES.SERVING_CONTAINER:
                this.stopContainer()
                break
            case Client.STATES.DEAD:
                // nothing to do
        }

        this.socket = null
    }

    function handleSecret(gottenSecret) {
        if (gottenSecret === nconf.get('secret')) {
            this.log("Correct secret received")
            this.startContainer()
        } else {
            this.log("Incorrect secret from client; closing connection")
            errorClient.call(this, "Incorrect secret")
            this.state = Client.STATES.DEAD
        }
    }

    Client.prototype.init = function Client_init() {
        this.socket.setEncoding('utf8')
        this.socket.setTimeout(nconf.get('timeout'))
        this.socket.on('close', Client_handleSocketClose.bind(this))
        this.socket.on('data', function Client_socketOnData(data) {
            if (this.state == Client.STATES.WAITING_FOR_SECRET) {
                this.log("secret message has been received")
                handleSecret.call(this, data.trim())
            } else {
                this.log("client has sent some data that was ignored: %s",
                    data.trim())
            }
        }.bind(this))
        this.socket.on('timeout', function Client_socketOnTimeout() {
            this.log("Socket timeout reached; closing it")
            this.socket.destroy()
        }.bind(this))
        this.socket.on('error', function(err) {
            this.log("Socket error: %s", err)
            this.socket.destroy()
        }.bind(this))
    }

    function Client_addFirewallRule() {
        var iptablesRet,
            program = IPTABLES_EXEC
        this.log('Adding firewall rule, accepting connections on port %d', this.port)
        var parsedIp = ipaddr.process(this.socket.remoteAddress)
        if (parsedIp.kind() != 'ipv4') {
            this.log("Only IPv4 addresses are allowed; got %s", parsedIp)
            return false
        }

        var parameters = [
            '-t', 'nat',
            '-A', nconf.get('iptablesChain'),
            '-s', parsedIp.toString(), '-p', 'tcp',
            '--dport', this.port, '-j', 'DOCKER'
        ]

        this.log("Invoking %s %s", program, parameters.join(' '))
        iptablesRet = childProcess.spawnSync('iptables' , parameters)

        if (iptablesRet.status != 0) {
            this.log('Failed adding iptables rule: %d %s', iptablesRet.status,
                iptablesRet.stderr ? iptablesRet.stderr.toString() : '(null)')
            return false
        } else {
            this.iptablesParams = parameters
        }
        return true
    }

    function Client_deleteFirewallRule() {
        var iptablesRet,
            program = IPTABLES_EXEC,
            parameters = this.iptablesParams

        if (!this.iptablesParams) {
            return true
        }

        parameters[parameters.indexOf('-A')] = '-D'

        this.log("Removing firewall rule with %s %s", program, parameters.join(' '))

        iptablesRet = childProcess.spawnSync(program, parameters)

        if (iptablesRet.status !== 0) {
            console.log("Client %d: gailed deleting iptables rule: %s", this.n, iptablesRet)
            return false
        }
        return true
    }

    function Client_releaseContainerResources() {
        Client_deleteFirewallRule.call(this)

        this.log("Releasing port %d", this.port)
        pool.returnPort(this.port)
        this.port = undefined
        currentContainers--
        console.log("Current active containers: %d", currentContainers)
    }

    function Client_containerExitHandler(exitOrError, signal) {
        this.log("Container exit handler called: %s %s", exitOrError, signal)
        clearTimeout(this.container.readyTimeout)

        var doClose = function Client_doContainerClose(message) {
            Client_releaseContainerResources.call(this)
            setState.call(this, Client.STATES.DEAD)
            if (this.socket) {
                if (!message) {
                    this.log('Destroying socket after container exited')
                    this.socket.destroy()
                } else {
                    errorClient.call(this, message)
                }
            }
            this.emit('close') // no resources left
        }.bind(this)

        switch (this.state) {
            case Client.STATES.CONFIGURING_CONTAINER_THEN_DESTROY:
            case Client.STATES.CONFIGURING_CONTAINER:
                doClose('Error during container configuration; check logs')
                break
            case Client.STATES.DESTROYING_CONTAINER:
                this.log('Finished destroying the container')
                doClose()
                break
            case Client.STATES.SERVING_CONTAINER:
                doClose('Container has exited; check logs')
                break
            case Client.STATES.DEAD:
                this.log("Ignored exit event")
                // nothing to do
                break
            default:
                throw new Error('Unexpected state in container exit handler: ' + this.state)
        }
    }

    function Client_onDatabaseReady() {
        this.log('Database is ready')
        clearTimeout(this.container.readyTimeout)
        switch (this.state) {
            case Client.STATES.CONFIGURING_CONTAINER:
                setState.call(this, Client.STATES.SERVING_CONTAINER)
                var ret = Client_addFirewallRule.call(this)
                if (ret) {
                    this.socket.write("OK " + this.port + "\n")
                } else {
                    errorClient.call(this, "Error opening firewall port")
                }
                break
            case Client.STATES.CONFIGURING_CONTAINER_THEN_DESTROY:
                this.stopContainer()
                break
            default:
                throw new Error('Unexpected state in container exit handler: ' + this.state)
        }
    }

    function Client_databaseReadinessTimeout() {
        this.log('Reached timeout for database readiness')
        errorClient.call(this, 'Database readiness timeout reached')
        this.stopContainer()
    }

    Client.prototype.log = function Client_log(message) {
        var newMessage = "Client %d: " + message
        var newArgs = arguments
        Array.prototype.shift.call(newArgs) // remove orig message
        Array.prototype.unshift.call(newArgs, this.n)
        Array.prototype.unshift.call(newArgs, newMessage)

        console.log.apply(null, newArgs)
    }

    Client.prototype.startContainer = function Client_startContainer() {
        if (currentContainers >= nconf.get('maxContainers')) {
            this.socket.write("Max number of containers active reached")
            this.socket.close()
            return
        }

        setState.call(this, Client.STATES.CONFIGURING_CONTAINER)

        this.port = pool.retrieve()
        this.log('Chose port %d', this.port)

        currentContainers++
        console.log("Current active containers: %d", currentContainers)

        this.container = childProcess.spawn(DOCKER_EXEC, [
            'run',
            '-p', this.port + ':' + 1521,
            '--privileged',
            '--rm',
            '--name', 'oracle_' + this.port,
            nconf.get('dockerImage')
        ], {
            stdio: ['ignore', 'pipe', process.stderr]
        })
        this.log('Spawned docker process with pid %d', this.container.pid)

        this.container.on('error', Client_containerExitHandler.bind(this))
        this.container.on('exit', Client_containerExitHandler.bind(this))
        this.container.stdout.on('data', function(data) {
            if (data.toString().indexOf('Instance "ORCL", status READY') != -1) {
                this.log("Read chunk with magic substring")
                if (this.state == Client.STATES.CONFIGURING_CONTAINER ||
                        this.state == Client.STATES.CONFIGURING_CONTAINER_THEN_DESTROY) {
                    Client_onDatabaseReady.call(this)
                } else {
                    this.log("Ignoring chunk because state is %s", this.state)
                }

            }
        }.bind(this))
        this.container.readyTimeout = setTimeout(
            Client_databaseReadinessTimeout.bind(this), nconf.get('readyTimeout'))
    }

    Client.prototype.isStoppable = function Client_isStoppable() {
        return this.state == Client.STATES.CONFIGURING_CONTAINER ||
                this.state == Client.STATES.CONFIGURING_CONTAINER_THEN_DESTROY ||
                this.state == Client.STATES.SERVING_CONTAINER
    }

    Client.prototype.stopContainer = function Client_stopContainer() {
        if (!this.isStoppable()) {
            this.log("No container running/starting, nothing to stop")
            return
        }
        this.log("Run docker stop")
        setState.call(this, Client.STATES.DESTROYING_CONTAINER)
        var stopProcess = childProcess.spawn(DOCKER_EXEC, [
            'stop', 'oracle_' + this.port
        ])
        stopProcess.on('close', function docker_stop_close(code) {
            // if everything went all right, Client_containerExitHandler should be called too
            this.log("docker stop exited with code %d", code)
        }.bind(this))
    }

    return Client
})()

function initialCleanup() {
    console.log('Destroying possible leftover containers')
    pool.possibleContainerNames().forEach(function (container) {
        childProcess.spawnSync(DOCKER_EXEC, ['rm', '-f', container])
    })
    console.log('Done destroying possible leftover containers')

    var chain = nconf.get('iptablesChain')
    console.log("Flushing iptables chain %s", chain)
    childProcess.spawnSync(IPTABLES_EXEC, ['-t', '-nat', '-F', chain])
}
initialCleanup()

var server = tls.createServer({
    key:  fs.readFileSync(nconf.get('privateKey'), 'utf8'),
    cert: fs.readFileSync(nconf.get('certificate'), 'utf8'),
}, function server_newClient(socket) {
    console.log('Got connection from %s:%d', socket.remoteAddress, socket.remotePort)

    var client = new Client(socket)
    client.init()
    currentClients.add(client)
    client.on('close', function() {
        console.log('Forgetting about client %d', client.n)
        currentClients.delete(client)
    })
})

var currentClients = new Set()
server.listen(nconf.get('serverPort'), function () {
    console.log('Server bound')
})

function exitHandler(arg) {
    console.log('SIGINT or uncaught exception, will destroy %d clients: %s', currentClients.size, arg)
    server.close()
    currentClients.forEach(function(client) {
        client.stopContainer()
    })
}

process.on('SIGINT', exitHandler)
process.on('uncaughtException', exitHandler)
