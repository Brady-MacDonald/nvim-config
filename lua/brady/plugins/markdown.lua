return {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = "markdown",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },
    config = function()
        local render_markdown = require("render-markdown")
        render_markdown.setup({
            latex = { enabled = false },
            completions = { lsp = { enabled = true } }
        })
    end
}
