return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({
                style = "night",
                transparent = true,

            })
            vim.cmd.colorscheme("tokyonight")
        end
    },
    {
        "Bruenor/nvim-colorizer.lua",
        branch = "refactor/tbl_flatten-to-iter",
        config = function()
            require("colorizer").setup()
        end
    },
    {
        "HiPhish/rainbow-delimiters.nvim"
    }
}
