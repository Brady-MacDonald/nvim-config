-------------
-- Go snipptes
--------------
local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local snippet = luasnip.snippet

local fNode = luasnip.function_node
local tNode = luasnip.text_node
local iNode = luasnip.insert_node

-- Format Print Value
luasnip.add_snippets("go", {
    snippet("fpl", {
        tNode("fmt.Println("),
        iNode(1),
        tNode(")")
    })
})

-- Format Print String
luasnip.add_snippets("go", {
    snippet("fps", {
        tNode("fmt.Println(\""),
        iNode(1),
        tNode("\")")
    })
})

-- Format Print Wrapped
luasnip.add_snippets("go", {
    snippet("fpw",
        fmt('fmt.Println("----------------")\nfmt.Println({})\nfmt.Println("----------------")\n{}',
            { iNode(1), iNode(2) }
        ))
})

-- If Err Panic
luasnip.add_snippets("go", {
    snippet("iep",
        fmt('if err != nil {{\n  panic(err)\n}}\n{}',
            { iNode(1) }
        ))
})

-- Err Not Nil
luasnip.add_snippets("go", {
    -- TODO:
    snippet("enn",
        fmt('if err != nil {{\n  {}(err)\n}}\n{}',
            { iNode(1), iNode(2) }
        ))
})

-- Format the json struct tag for property
local json_struct_tag = function()
    local TS = require("brady.treesitter.json_struct_tag")

    local name = TS.json_struct_tag()
    vim.notify(name)

    return name
end

luasnip.add_snippets("go", {
    snippet("js", fmt('`json:"{}"`{}', { fNode(json_struct_tag), iNode(2) }))
})

-- Log out function parameters
local param_log = function()
    local TS = require("brady.treesitter.function_start")

    local func_node, paramters = TS.get_func_node("go")
    assert(func_node ~= nil, "Unable to get TSNode for go function")

    local clg = ""

    for _, param in ipairs(paramters) do
        clg = clg .. "fmt.Println(" .. param .. "); "
    end

    return clg
end

-- Format Print Parameters
luasnip.add_snippets("go", {
    snippet("fpp",
        fmt('fmt.Println("----------------")\n{}\nfmt.Println("----------------")\n{}',
            { fNode(param_log), iNode(1) }
        ))
})
