return {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
        local ibl = require("ibl");
        ibl.setup({
            scope = {
                enabled = false
            }
        })
    end
}
