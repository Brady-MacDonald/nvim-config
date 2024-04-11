-------------
-- Add custom snippets to luasnip
-- Uses the same LuaSnip source for nvim-cmp
-- We just insert our own snippets here...
--------------

local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

-- s - Create brand new snippet
local s = luasnip.s

-- sn - SnippetNode, used to return from dynamic snippet
-- local sn - luasnip.sn

local snippet = luasnip.snippet
local tNode = luasnip.text_node
local iNode = luasnip.insert_node
local fNode = luasnip.function_node

luasnip.add_snippets("lua", {
    snippet("ps", {
        tNode('print("'),
        iNode(1),
        tNode('")')
    })
})

luasnip.add_snippets("lua", {
    s("pw",
        fmt([[
            print("----------------")
            print({})
            print("----------------")
            {}
        ]],
            { iNode(1), iNode(2) }
        ))
})

luasnip.add_snippets("lua", {
    s("req",
        fmt([[local {} = require("{}")]],
            { fNode(function(insert_nodes)
                local parts = vim.split(insert_nodes[1][1], ".", { plain = true })
                return parts[#parts] or ""
            end, { 1 }), iNode(1) }
        ))
})
