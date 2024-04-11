-------------
-- TypeScript snipptes
--------------

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
    -- Get node at current position
    local currentNode = vim.treesitter.get_node()

    local TYPESCRIPT_QUERY =
    "(function_declaration (formal_parameters (required_parameter (identifier) @iden)) @formal) @func"
    local TYPESCRIPT_FUNC = "function_declaration"

    while currentNode:parent() ~= nil do
        if (currentNode:type() == TYPESCRIPT_FUNC) then break end
        currentNode = currentNode:parent()
    end

    local clg = "console.log('-------------------');"

    local functionNode = currentNode
    local query = vim.treesitter.query.parse("typescript", TYPESCRIPT_QUERY)

    -- Iterate over lisp captures
    for id, captureGroup, _ in query:iter_captures(functionNode, 0) do
        local captureName = query.captures[id]
        if captureName == "iden" then
            local start_row, start_col, end_row, end_col = captureGroup:range()

            local param = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
            clg = clg .. "console.log(" .. param[1] .. ");"
        end
    end

    clg = clg .. "console.log('-------------------');"
    return clg
end

-- Use TS to get surrounding function and log all parameters
luasnip.add_snippets("typescript", {
    snippet("pl", fNode(param_log))
})
