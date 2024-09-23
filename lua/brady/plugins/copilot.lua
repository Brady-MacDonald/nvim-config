return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            require("copilot").setup({
                suggestion = { enabled = false },
                panel = { enabled = false },
            })

            local panel = require("copilot.panel")
            vim.keymap.set("n", "<Leader>po", panel.open, { desc = "Copilot: Open" })
            vim.keymap.set("n", "<Leader>pd", panel.teardown, { desc = "Copilot: TearDown" })
            vim.keymap.set("n", "<Leader>pr", panel.refresh, { desc = "Copilot: Refresh" })
            vim.keymap.set("n", "<Leader>pn", panel.jump_next, { desc = "Copilot: Next" })
            vim.keymap.set("n", "<Leader>pp", panel.jump_prev, { desc = "Copilot: Prev" })
            vim.keymap.set("n", "<Leader>pa", panel.accept, { desc = "Copilot: Accept" })

            local suggestion = require("copilot.suggestion")
            vim.keymap.set("n", "<Leader>as", suggestion.toggle_auto_trigger)
        end
    },
    {
        "zbirenbaum/copilot-cmp",
        event = "InsertEnter",
        config = function()
            require("copilot_cmp").setup()
        end
    }
}
