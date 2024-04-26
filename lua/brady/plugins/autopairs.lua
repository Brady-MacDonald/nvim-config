return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            fast_wrap = {
                map = '<C-s>',
            },
        })
    end
}
