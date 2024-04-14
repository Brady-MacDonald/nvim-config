local TS = {}

-- TODO: Function expression vs. function declaration in query
local TREE_SITTER = {
    typescript = {
        QUERY = "(function_declaration (formal_parameters (required_parameter (identifier) @iden)) @formal) @func",
        FUNC = "function_declaration"
    },
    javascript = {
        QUERY = "(function_declaration (formal_parameters (identifier) @iden) @formal) @func",
        FUNC = "function_declaration"
    },
    go = {
        QUERY = "(function_declaration (parameter_list (parameter_declaration (identifier) @iden)) @formal) @func",
        FUNC = "function_declaration"
    },
}

---Get the surrounding function node and its parameters
---@param file_type string
---@return table|nil function_node
---@return string[]  params Function input parameters
TS.get_func_node = function(file_type)
    local curr_node = vim.treesitter.get_node()

    local ts_query = TREE_SITTER[file_type]
    if ts_query == nil then
        return nil, {}
    end

    while curr_node:parent() ~= nil do
        if (curr_node:type() == ts_query.FUNC) then break end
        curr_node = curr_node:parent()
    end

    local query = vim.treesitter.query.parse(file_type, ts_query.QUERY)

    -- Iterate over
    local params = {}
    for id, captureGroup, _ in query:iter_captures(curr_node, 0) do
        local captureName = query.captures[id]
        if captureName == "iden" then
            local start_row, start_col, end_row, end_col = captureGroup:range()
            local param = vim.api.nvim_buf_get_text(0, start_row, start_col, end_row, end_col, {})
            if #param == 1 then
                table.insert(params, param[1])
            end
        end
    end

    return curr_node, params
end

return TS
