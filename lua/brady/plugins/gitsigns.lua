return {
    "lewis6991/gitsigns.nvim",
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup()

        vim.keymap.set("n", "ghn", function() gitsigns.nav_hunk("next") end, { desc = "Git: HunkNext" })
        vim.keymap.set("n", "ghb", function() gitsigns.nav_hunk("prev") end, { desc = "Git: HunkBack" })
        vim.keymap.set("n", "gbf", gitsigns.blame, { desc = "Git: BlameFile" })
        vim.keymap.set("n", "gbl", gitsigns.blame_line, { desc = "Git: BlameLine" })
        vim.keymap.set("n", "gbt", gitsigns.toggle_current_line_blame, { desc = "Git: BlameToggle" })
        vim.keymap.set("n", "ghr", gitsigns.reset_hunk, { desc = "Git: HunkReset" })
        vim.keymap.set("n", "ghs", gitsigns.stage_hunk, { desc = "Git: HunkStage" })
        vim.keymap.set("n", "ghd", gitsigns.diffthis, { desc = "Git: HunkDiff" })
        vim.keymap.set("n", "gp", gitsigns.preview_hunk, { desc = "Git: PreviewHunk" })
        vim.keymap.set("n", "gip", gitsigns.preview_hunk_inline, { desc = "Git: PreviewHunkInline" })
    end
}
