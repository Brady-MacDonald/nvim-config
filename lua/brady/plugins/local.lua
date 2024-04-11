-- Provide a local path to Lazy
-- Used to load from local dir, not a github repo

return {
    {
        dir = '~/apps/treesitting',
    },
    {
        dir = '~/apps/autocmd',
    },
    {
        dir = '~/apps/json-tree-appsettings',
        config = function()
            local jTree = require("json-tree")
            jTree.setup({ devUrl = "some URL path" })

            local clear = function()
                package.loaded["json-tree"] = nil

                local json_tree = require("json-tree")
                json_tree.setup({ devUrl = "teseees" })
                json_tree.dev()
            end
            vim.keymap.set("n", "<leader>js", clear)
        end
    }
}
