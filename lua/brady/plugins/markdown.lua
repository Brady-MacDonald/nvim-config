return {
    'MeanderingProgrammer/render-markdown.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
        local render_markdown = require("render-markdown")
        render_markdown.setup({
            filetypes = { "markdown", "muse" },
        })

        vim.api.nvim_set_hl(0, "RenderMarkdownDash", {
            fg = "#8FBCBB",
            bg = "bg",
        })
    end
}
