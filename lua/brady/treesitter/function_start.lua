local TS = {}

-- TODO: Function expression vs. function declaration in query
local TREE_SITTER = {
    typescript = {
        QUERY = "(function_declaration (formal_parameters (required_parameter (identifier) @iden)) @formal) @func",
        FUNC = { "function_declaration" }
    },
    javascript = {
        QUERY = "(function_declaration (formal_parameters (identifier) @iden) @formal) @func",
        FUNC = { "function_declaration", "arrow_function" }
    },
    go = {
        QUERY = "(function_declaration (parameter_list (parameter_declaration (identifier) @iden)) @formal) @func",
        FUNC = { "function_declaration", "method_declaration" },
    },
}

---Get the TSNode for the surrounding function, and its parameters
---@param file_type string
---@return TSNode|nil function_node
---@return string[]  params Function input parameters
TS.get_func_node = function(file_type)
    P(file_type)
    local curr_node = vim.treesitter.get_node()
    assert(curr_node ~= nil, "No treesitter node available")

    local ts_query = TREE_SITTER[file_type]
    assert(ts_query ~= nil, "No TS query for current filetype: " .. file_type)

    while curr_node:parent() ~= nil do
        -- Iterate up tree until we reach function/method TSNode
        if (vim.tbl_contains(ts_query.FUNC, curr_node:type())) then
            break
        end

        curr_node = curr_node:parent()
        assert(curr_node ~= nil, "Unable to access parent node")
    end

    local query = vim.treesitter.query.parse(file_type, ts_query.QUERY)
    local func_node = curr_node

    -- Iterate over
    local params = {}
    for id, captureNode, _ in query:iter_captures(func_node, 0) do
        local captureName = query.captures[id]
        if captureName == "iden" then
            -- local param = vim.treesitter.get_node_text(captureGroup, 0)
            local start_row, start_col, end_row, end_col = captureNode:range()
            local param = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
            if #param == 1 then
                table.insert(params, param[1])
            end
        end
    end

    return func_node, params
end

return TS
