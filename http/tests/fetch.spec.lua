return function ()
    local JestGlobals = (require)("@pkg/@jsdotlua/jest-globals")
    local jestExpect = JestGlobals.expect

    local http = require("../init")
    local Promise = require("@pkg/@jsdotlua/promise")

    describe("fetch", function()
        it("should GET", function()
            local resultPromise = http.fetch("https://github.com/")

            jestExpect(resultPromise).toBeDefined()
            jestExpect(Promise.is(resultPromise)).toBe(true)

            local result = resultPromise:expect()
            jestExpect(result).toBeDefined()

            local resultText = result:text():expect()

            jestExpect(resultText).toBeDefined()
            jestExpect(typeof(resultText)).toBe("string")
        end)
    end)
end