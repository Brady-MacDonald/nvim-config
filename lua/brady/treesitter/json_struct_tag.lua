local Go = {}

local Q = "(field_declaration (field_identifier) @field )"

-- Get the Property name in a struct to insert into the json struct tag
Go.json_struct_tag = function()
    local curr_node = vim.treesitter.get_node()
    assert(curr_node ~= nil, "No TSNode found")

    P(curr_node.type(curr_node))
    local count = curr_node:child_count()

    for ts_node, str in curr_node:iter_children() do
        print("----------------")
        P(ts_node:type())
        P(str)
        if str == "name" then
            P(ts_node:range())
            local xx = vim.treesitter.get_node_text(ts_node, 0)
            P(xx)
        end

        print("----------------")
    end


    -- MP(curr_node)
    -- local last = curr_node:child(count - 3)
    -- local five = curr_node:child(count - 5)

    local sibling = curr_node:prev_sibling()
    assert(sibling ~= nil, "Nil sibling")

    -- local curr_text = vim.treesitter.get_node_text(curr_node, 0)
    -- local last_text = vim.treesitter.get_node_text(last, 0)
    -- local okay = vim.treesitter.get_node_text(five, 0)
    local sib_text = vim.treesitter.get_node_text(sibling, 0)

    return sib_text
end

return Go
