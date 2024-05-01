-- Harpoon

return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

        vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: add" })
        vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon: menu" })

        vim.keymap.set("n", "<leader>hh", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>hj", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>hk", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>hl", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>hf", function() harpoon:list():next() end, { desc = "Harpoon: Next" })
        vim.keymap.set("n", "<leader>hd", function() harpoon:list():prev() end, { desc = "Harpoon: Prev" })
    end
}
