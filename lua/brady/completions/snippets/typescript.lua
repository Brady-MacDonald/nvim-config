local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local snippet = luasnip.snippet
local s = luasnip.s

local tNode = luasnip.text_node
local iNode = luasnip.insert_node
local fNode = luasnip.function_node
-- local cNode = luasnip.choice_node
--
-- luasnip.add_snippets("typescript", {
--     snippet("choice", { cNode(1, tNode("Hello"), tNode("World"))})
-- })

luasnip.add_snippets("typescript", {
    snippet("cl", {
        tNode('console.log('),
        iNode(1),
        tNode(')')
    })
})

luasnip.add_snippets("typescript", {
    snippet("sl", {
        tNode('console.log("'),
        iNode(1, "Here"),
        tNode('")')
    })
})

luasnip.add_snippets("typescript", {
    s("wl",
        fmt("console.log('----------------');\nconsole.log({});\nconsole.log('----------------');\n",
            { iNode(1) }
        ))
})

local param_log = function()
    local TS = require("brady.treesitter.function_start")

    local func_node, paramters = TS.get_func_node("typescript")
    if func_node == nil then
        vim.notify("Unable to perform ParameterLog", "error")
        return
    end

    local clg = "console.log('-------------------');"

    for idx, param in ipairs(paramters) do
        clg = clg .. "console.log(" .. param .. ");"
    end

    clg = clg .. "console.log('-------------------');"
    return clg
end

-- Use TS to get surrounding function and log all parameters
luasnip.add_snippets("typescript", {
    snippet("pl", fNode(param_log))
})
