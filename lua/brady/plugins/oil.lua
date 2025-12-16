return {
    'stevearc/oil.nvim',
    event = "VeryLazy",
    dependencies = { { "nvim-mini/mini.icons", opts = {} } },
    config = function()
        local oil = require("oil")
        oil.setup({
            default_file_explorer = true,
            skip_confirm_for_simple_edits = true,
            float = {
                padding = 3,
            },
            view_options = {
                show_hidden = true,
            }
        })

        vim.keymap.set("n", "<leader>ef", oil.open_float, { desc = "Oil: Float" })
        vim.keymap.set("n", "<leader>ew", oil.open, { desc = "Oil: Open" })
        vim.keymap.set("n", "<leader>ep", function() oil.open(vim.fn.getcwd()) end, { desc = "Oil: Pwd" })
    end
}
