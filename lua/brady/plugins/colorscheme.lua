return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    {
        'ray-x/aurora',
        init = function()
            vim.g.aurora_italic = 1
            vim.g.aurora_transparent = 1
            vim.g.aurora_bold = 1
        end,
        config = function()
            -- vim.cmd.colorscheme("aurora")
            -- vim.api.nvim_set_hl(0, '@number', { fg = '#e933e3' })
        end
    },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("tokyonight").setup({ style = "night" })
            vim.cmd.colorscheme("tokyonight")
        end
    },
}
