return {
    "kawre/leetcode.nvim",
    build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
    command = "Leet",
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        local leetcode = require("leetcode")

        leetcode.setup({
            lang = "python3"
        })

        vim.keymap.set("n", "<leader><C-'>", "<cmd>Leet run<CR>")
    end
}
