-------------
-- Javascript snipptes
--------------

local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local snippet = luasnip.snippet
local s = luasnip.s

local tNode = luasnip.text_node
local iNode = luasnip.insert_node
local fNode = luasnip.function_node

luasnip.add_snippets("vue", {
    snippet("clg", {
        tNode('console.log('),
        iNode(1),
        tNode(')')
    })
})

luasnip.add_snippets("javascript", {
    snippet("clg", {
        tNode('console.log('),
        iNode(1),
        tNode(')')
    })
})

luasnip.add_snippets("javascript", {
    snippet("slg", {
        tNode('console.log("'),
        iNode(1, "Here"),
        tNode('")')
    })
})

luasnip.add_snippets("javascript", {
    s("wlg",
        fmt("console.log('----------------');\nconsole.log({});\nconsole.log('----------------');\n",
            { iNode(1) }
        ))
})

local param_log = function()
end

-- Parameter Log:
-- Use TS to get surrounding function and log a parameter
luasnip.add_snippets("javascript", {
    snippet("plg", fNode(param_log))
})

local tester = function()
    return "running"
end

luasnip.add_snippets("javascript", {
    snippet("tester", fNode(tester))
})
