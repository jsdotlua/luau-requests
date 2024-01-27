#!/bin/sh

set -e

rm -rf roblox

mkdir -p roblox

cp -r http/ roblox/

rojo sourcemap model.project.json -o sourcemap.json

darklua process http roblox/http
darklua process node_modules roblox/node_modules

./scripts/remove-tests.sh roblox

cp model.project.json roblox/

mkdir -p build

rojo build roblox/model.project.json -o build/luau-requests.rbxm
