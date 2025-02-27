return {
    "Brady-MacDonald/telescope-directus.nvim",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    event = "VeryLazy",
    cmd = "Directus",
    config = function()
        local directus = require("directus")

        directus.setup({
            url = vim.env.DIRECTUS_URL,
            token = vim.env.DIRECTUS_TOKEN,
            show_hidden = true
        })

        vim.keymap.set("n", "<leader>oi", directus.directus_collections, { desc = "Directus: Collection" })
    end
}
