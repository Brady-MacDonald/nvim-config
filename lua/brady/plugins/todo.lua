return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local todo_comments = require("todo-comments")
        todo_comments.setup()

        vim.keymap.set("n", "]t", function() todo_comments.jump_next() end, { desc = "TodoComments: Next todo" })
        vim.keymap.set("n", "[t", function() todo_comments.jump_prev() end, { desc = "TodoComments: Previous todo" })

        vim.keymap.set("n", "<leader>tt", "<cmd>:TodoTelescope<CR>", { desc = "TodoComments: Telescope" })
        vim.keymap.set("n", "<leader>tq", "<cmd>:TodoQuickFix<CR>", { desc = "TodoComments: QuickFix" })
    end
}
