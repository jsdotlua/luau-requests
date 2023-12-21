#!/bin/sh

set -e

mkdir -p build

rm -f build/luau-requests.lua

darklua process --config .darklua-bundle.json http/init.lua build/luau-requests.lua
