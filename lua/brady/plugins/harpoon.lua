-- Harpoon

return {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- branch = "harpoon2",
    config = function()
        -- local harpoon = require("harpoon")
        local mark = require("harpoon.mark")
        local ui = require("harpoon.ui")

        -- harpoon:setup()

        vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Harpoon: AddFile" })
        vim.keymap.set("n", "<leader>hr", mark.rm_file, { desc = "Harpoon: RemoveFile" })
        vim.keymap.set("n", "<leader>hm", ui.toggle_quick_menu, { desc = "Harpoon: QuickMenu" })

        vim.keymap.set("n", "<leader>hh", function() ui.nav_files(0) end)
        vim.keymap.set("n", "<leader>hj", function() ui.nav_files(1) end)
        vim.keymap.set("n", "<leader>hk", function() ui.nav_files(2) end)
        vim.keymap.set("n", "<leader>hl", function() ui.nav_files(3) end)

        vim.keymap.set("n", "<leader>hf", ui.nav_next, { desc = "Harpoon: NavNext" })
        vim.keymap.set("n", "<leader>hb", ui.nav_prev, { desc = "Harpoon: NavPrev" })
    end
}
