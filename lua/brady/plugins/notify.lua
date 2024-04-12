return {
    "rcarriga/nvim-notify",
    config = function()
        vim.notify = require("notify")

        vim.keymap.set("n", "<leader>nh", "<cmd>Telescope notify<CR>")
        -- require('telescope').extensions.notify.notify()
    end
}
