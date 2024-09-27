return {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
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

        vim.keymap.set("n", "-", oil.open_float)
        vim.keymap.set("n", "<leader>-", oil.open)
        vim.keymap.set("n", "<leader>-r", function() oil.open(vim.fn.getcwd()) end)
    end
}
