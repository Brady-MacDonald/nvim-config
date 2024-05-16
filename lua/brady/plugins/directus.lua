return {
    dir = "~/nssmp/telescope-directus.nvim",
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        require("telescope").load_extension("directus")

        local directus = require("directus")
        local sbr_config = require("sbr.config")

        directus.setup(sbr_config.directus_local)
    end
}
