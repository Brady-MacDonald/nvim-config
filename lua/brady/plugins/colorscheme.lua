return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "moon",
                on_highlights = function() end,
                on_colors = function() end
            })
            vim.cmd.colorscheme("tokyonight")
        end
    },
    {
        "Bruenor/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                name = false
            })
        end
    },
    {
        "HiPhish/rainbow-delimiters.nvim"
    }
}
