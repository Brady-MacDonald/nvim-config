return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        config = function()
            require("snacks").setup({
                input = {
                    enabled = true, -- Enhances opencode Ask
                },
                picker = {
                    enabled = true, -- Enhances opencode Select
                    win = {
                        input = {
                            keys = {
                                ["<a-o>"] = { "opencode_send", mode = { "n", "i" } },
                            },
                        },
                    },
                    actions = {
                        opencode_send = function(picker)
                            local items = vim.tbl_map(function(item)
                                return item.file and require("opencode").format({
                                        path = item.file,
                                        from = item.pos,
                                        to = item.end_pos,
                                    })
                                    or item.text
                            end, picker:selected({ fallback = true }))

                            require("opencode").prompt(table.concat(items, ", ") .. " ")
                        end,
                    },
                },
            })
        end,
    },
}
