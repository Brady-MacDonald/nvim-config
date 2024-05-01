-- Tree sitter is a core Neovim feature: vim.treesitter
-- This plugin allows a way to manage the individual parsers
-- Each programming language requires a unique parser, based on that languages syntax
-- nvim-treesitter allows for easy installation of additional language parsers
-- Otherwise this would have to be done manually: vim.treesitter.language.add()
-- It provides a /queries folder with scheme queries for the ast based on a lot of languages
-- These queries can provide better syntax highlighting as they are based on the capture groups of the queries

return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "lua", "python", "javascript" },
            auto_install = true,
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
            },
        }
    end
}
