-------------
-- Go snipptes
--------------
local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local snippet = luasnip.snippet
local s = luasnip.s

local fNode = luasnip.function_node
local tNode = luasnip.text_node
local iNode = luasnip.insert_node

luasnip.add_snippets("go", {
    snippet("cl", {
        tNode("fmt.Println("),
        iNode(1),
        tNode(")")
    })
})

luasnip.add_snippets("go", {
    s("wcl",
        fmt('fmt.Println("----------------");\nfmt.Println({});\nfmt.Println("----------------");\n',
            { iNode(1) }
        ))
})

luasnip.add_snippets("go", {
    s("enn",
        fmt('if err != nil {{\n {} err\n}}\n{}',
            { iNode(1), iNode(2) }
        ))
})

local param_log = function()
    local TS = require("brady.treesitter.function_start")

    local func_node, paramters = TS.get_func_node("go")
    if func_node == nil then
        vim.notify("Unable to perform ParameterLog", "error")
        return
    end

    local clg = "fmt.Println(\"---------------\"); "

    for idx, param in ipairs(paramters) do
        clg = clg .. "fmt.Println(" .. param .. "); "
    end

    clg = clg .. "fmt.Println(\"---------------\");"
    return clg
end

-- Use TS to get surrounding function and log all parameters
luasnip.add_snippets("go", {
    snippet("pl", fNode(param_log))
})
