local JS = {}

local Q = "(field_declaration (field_identifier) @field )"

JS.some_func = function()
    local curr_node = vim.treesitter.get_node()
    assert(curr_node ~= nil)

    P(curr_node.type(curr_node))
    local count = curr_node:child_count()
    P(count)


    -- MP(curr_node)
    local last = curr_node:child(count - 3)
    local five = curr_node:child(count - 5)

    local sibling = curr_node:prev_sibling()
    assert(sibling ~= nil, "Nil sibling")

    local curr_text = vim.treesitter.get_node_text(curr_node, 0)
    local last_text = vim.treesitter.get_node_text(last, 0)
    local okay = vim.treesitter.get_node_text(five, 0)
    local sib_text = vim.treesitter.get_node_text(sibling, 0)

    P(curr_text)
    P(last_text)
    P(okay)
    P(sib_text)

    return sib_text
end

return JS
