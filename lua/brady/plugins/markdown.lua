return {
    'MeanderingProgrammer/render-markdown.nvim',
    event = "VeryLazy",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = function()
        local render_markdown = require("render-markdown")
        render_markdown.setup({
            completions = { lsp = { enabled = true } }
        })
    end
}
