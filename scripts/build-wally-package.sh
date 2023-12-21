#!/bin/sh

set -e

rm -rf roblox/node_modules

mkdir -p roblox

cp -rL node_modules/ roblox/

./scripts/remove-tests.sh roblox/node_modules

rm -rf build/wally

module_name=luau-requests

echo Process package $module_name

wally_package=build/wally
roblox_package=roblox

mkdir -p $wally_package
cp LICENSE $wally_package/LICENSE
cp default.project.json $wally_package
node ./scripts/npm-to-wally.js package.json $wally_package/wally.toml $roblox_package/wally-package.project.json

cp .darklua-wally.json $roblox_package
cp -r roblox/node_modules/.luau-aliases/* $roblox_package

rojo sourcemap $roblox_package/wally-package.project.json --output $roblox_package/sourcemap.json

darklua process --config $roblox_package/.darklua-wally.json $roblox_package/http $wally_package/http

wally package --project-path $wally_package --list
