return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            window = {
                width = 35,
                mappings = {
                    ["<C-d>"] = "add_directory",
                }
            },
            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false
                }
            }
        })

        vim.keymap.set("n", "<leader>ne", "<cmd>Neotree filesystem reveal left<CR>", { desc = "Neotree: RevealLeft" })
        vim.keymap.set("n", "<leader>nw", "<cmd>Neotree filesystem reveal right<CR>", { desc = "Neotree: RevealRight" })
    end,
}
