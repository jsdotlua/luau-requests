#!/bin/sh

set -e

rm -rf roblox

mkdir -p roblox

cp -r http roblox/http

./scripts/remove-tests.sh roblox

wally_package=build/wally
rm -rf $wally_package

echo Process package

mkdir -p $wally_package
cp LICENSE $wally_package/LICENSE

node ./scripts/npm-to-wally.js package.json $wally_package/wally.toml roblox/wally-package.project.json

cp .darklua-wally.json roblox
cp -r node_modules/.luau-aliases/* roblox

rojo sourcemap roblox/wally-package.project.json --output roblox/sourcemap.json

darklua process --config roblox/.darklua-wally.json roblox/http $wally_package/http

cp default.project.json $wally_package
wally package --project-path $wally_package --list
