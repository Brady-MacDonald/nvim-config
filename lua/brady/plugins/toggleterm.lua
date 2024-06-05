return {
    'akinsho/toggleterm.nvim',
    config = function()
        local toggleterm = require("toggleterm")
        toggleterm.setup()

        vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm direction=float<CR>")
        vim.keymap.set("n", "<leader>tb", "<cmd>ToggleTerm direction=horizontal<CR>")
    end
}
