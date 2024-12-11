return {
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        config = function()
            require("noice").setup({
                views = {
                    cmdline_popup = {
                        position = {
                            row = 5,
                            col = "50%",
                        },
                        size = {
                            width = 70,
                            height = "auto",
                        },
                    },
                    popupmenu = {
                        relative = "editor",
                        position = {
                            row = 8,
                            col = "50%",
                        },
                        size = {
                            width = 60,
                            height = 10,
                        },
                        border = {
                            style = "rounded",
                            padding = { 0, 1 },
                        },
                        win_options = {
                            winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
                        },
                    },
                },
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
            local notify = require("notify")

            notify.setup({
                background_colour = "#000000",
            })

            vim.keymap.set("n", "<leader>nd", notify.dismiss, { desc = "Notify Dismiss" })
            vim.keymap.set("n", "<leader>tn", "<cmd>Telescope notify<CR>")

            require("telescope").load_extension("noice")
            require('telescope').load_extension("notify")
        end
    }
}
