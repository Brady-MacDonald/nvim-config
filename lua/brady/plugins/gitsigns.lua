return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup()

        vim.keymap.set("n", "<leader>ghn", function() gitsigns.nav_hunk("next") end, { desc = "Git: HunkNext" })
        vim.keymap.set("n", "<leader>ghb", function() gitsigns.nav_hunk("prev") end, { desc = "Git: HunkBack" })
        vim.keymap.set("n", "<leader>ghr", gitsigns.reset_hunk, { desc = "Git: HunkReset" })
        vim.keymap.set("n", "<leader>ghs", gitsigns.stage_hunk, { desc = "Git: HunkStage" })

        vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, { desc = "Git: PreviewHunk" })
        vim.keymap.set("n", "<leader>gbl", gitsigns.blame_line, { desc = "Git: BlameLine" })
    end
}
