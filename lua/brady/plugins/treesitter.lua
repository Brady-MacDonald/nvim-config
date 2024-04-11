-- Tree sitter is a core Neovim feature: vim.treesitter
-- This plugin allows a way to manage the individual parsers
-- Each programming langauge requires a unique parser, based on that languages syntax
-- nvim-treesitter allows for easy installation of additional language parsers

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
