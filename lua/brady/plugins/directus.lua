return {
    "Brady-MacDonald/telescope-directus.nvim",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        local directus = require("directus")

        directus.setup({
            url = "https://directus-uat.sbrfeeds.com",
            token = "4a1c8fa80f4c4d2c887a0fe628fcf353",
            show_hidden = true
        })
    end
}
