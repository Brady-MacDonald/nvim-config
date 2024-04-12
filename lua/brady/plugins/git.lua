return {
    "lewis6991/gitsigns.nvim",
    config = function()
        require("gitsigns").setup()

        vim.keymap.set("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Git: PreviewHunk" })
        vim.keymap.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Git: BlameLine" })
    end
}
