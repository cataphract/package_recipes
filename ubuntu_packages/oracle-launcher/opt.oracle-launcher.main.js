#include <tunables/global>

/opt/oracle-launcher/main.js {
  #include <abstractions/base>
  #include <abstractions/nameservice>

  network inet stream,

  /opt/oracle-launcher/** r,
  /etc/oracle-launcher/* r,
  /proc/meminfo r,
  /opt/oracle-launcher/main.js rix,
  "/usr/bin/env node" ix,
  "/usr/bin/node" rix,
  "/sbin/iptables" Ux,
  "/sbin/xtables-multi" Ux,
  "/sbin/ip6tables" Ux,
# technically, this allows anything to be executed, as access to docker
# is root-equivalent
  "/usr/bin/docker" Ux,
}
