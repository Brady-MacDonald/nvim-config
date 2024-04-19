return {
    {
        "folke/noice.nvim",
        events = "VeryLazy",
        config = function()
            require("noice").setup({
                routes = {
                    {
                        view = "cmdline",
                        filter = { event = "msg_showmode" },
                    },
                },
                presets = {
                    bottom_search = true,          -- use a classic bottom cmdline for search
                    command_palette = false,       -- position the cmdline and popupmenu together
                    long_message_to_split = false, -- long messages will be sent to a split
                    inc_rename = false,            -- enables an input dialog for inc-rename.nvim
                }
            })
        end
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            vim.keymap.set("n", "<leader>tn", "<cmd>Telescope notify<CR>")
            require("telescope").load_extension("noice")
            require('telescope').load_extension("notify")
        end
    }
}
