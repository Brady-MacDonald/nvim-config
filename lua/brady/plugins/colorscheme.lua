return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            -- transparent = true,
            style = "moon",
            on_highlights = function() end,
            on_colors = function() end
        })
        vim.cmd.colorscheme("tokyonight")
    end
}
