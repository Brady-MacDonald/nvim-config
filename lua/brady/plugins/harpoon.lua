return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    branch = "harpoon2",
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({
            brady = {
                select_with_nil = true
            }
        })

        vim.keymap.set("n", "<leader>hh", function() harpoon:list():add() end, { desc = "Harpoon: add" })
        vim.keymap.set("n", "<leader>hm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
            { desc = "Harpoon: menu" })

        vim.keymap.set("n", "<leader>hf", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<leader>hd", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<leader>hs", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<leader>ha", function() harpoon:list():select(4) end)

        -- Toggle previous & next buffers stored within Harpoon list
        vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon: Next" })
        vim.keymap.set("n", "<leader>hb", function() harpoon:list():prev() end, { desc = "Harpoon: Back" })
    end
}
