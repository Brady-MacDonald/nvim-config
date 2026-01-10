return {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    config = function()
        local ibl = require("ibl");
        ibl.setup({
            scope = {
                enabled = false
            }
        })
    end
}
