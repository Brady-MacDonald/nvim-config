return {
    dir = "~/sbr/neovim",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        -- local telescope = require("telescope")
        -- telescope.load_extension("directus")

        local directus = require("directus")
        local sbr_config = require("sbr.config")

        directus.setup(sbr_config.directus_local)
    end
}
