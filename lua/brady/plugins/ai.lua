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

            vim.keymap.set("n", "<Leader>ad", "<cmd>Copilot disable<CR>", { desc = "Copilot: Disable" })
            vim.keymap.set("n", "<Leader>ae", "<cmd>Copilot enable<CR>", { desc = "Copilot: Enable" })

            local panel = require("copilot.panel")
            vim.keymap.set("n", "<Leader>ao", panel.open, { desc = "Copilot: Open" })
            vim.keymap.set("n", "<Leader>at", panel.teardown, { desc = "Copilot: TearDown" })
            vim.keymap.set("n", "<Leader>ar", panel.refresh, { desc = "Copilot: Refresh" })
            vim.keymap.set("n", "<Leader>an", panel.jump_next, { desc = "Copilot: Next" })
            vim.keymap.set("n", "<Leader>ap", panel.jump_prev, { desc = "Copilot: Prev" })
            vim.keymap.set("n", "<Leader>aa", panel.accept, { desc = "Copilot: Accept" })

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
