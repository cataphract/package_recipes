#!/bin/bash

DIR=/opt/i2b2workbench
export ECLIPSE_HOME="$DIR"
export GDK_NATIVE_WINDOWS=true

mkdir -p "$HOME/.i2b2workbench"
if [[ ! -f "$HOME/.i2b2workbench/i2b2workbench.properties" ]]; then
  cp "$DIR"/i2b2workbench.properties "$HOME/.i2b2workbench"
fi
cd "$HOME/.i2b2workbench/"

exec "$DIR"/i2b2workbench
