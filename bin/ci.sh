#!/bin/bash

set -x

echo "Remove .robloxrc from dev dependencies"
find Packages/Dev -name "*.robloxrc" | xargs rm -f
find Packages/_Index -name "*.robloxrc" | xargs rm -f

echo "Run static analysis"
selene http/src
roblox-cli analyze tests.project.json
stylua -c http/src

echo "Run tests"
roblox-cli run --load.place tests.project.json --run bin/spec.lua --lua.globals=__DEV__=true --fastFlags.allOnLuau --fastFlags.overrides "UseDateTimeType3=true" "EnableLoadModule=true" "EnableDelayedTaskMethods=true"
