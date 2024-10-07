return {
    "Brady-MacDonald/telescope-directus.nvim",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        local directus = require("directus")
        local url = vim.env.DIRECTUS_URL
        local token = vim.env.DIRECTUS_TOKEN

        directus.setup({
            url = url,
            token = token,
            show_hidden = true
        })
    end
}
