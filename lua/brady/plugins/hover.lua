return {
    "lewis6991/hover.nvim",
    config = function()
        local hover = require('hover')
        hover.config({
            providers = {
                'hover.providers.diagnostic',
                'hover.providers.dap',
                'hover.providers.man',
                {
                    module = 'hover.providers.lsp',
                    priority = 2000,
                    name = 'LSP'
                },
            },
            preview_window = false,
            title = true,
        })

        vim.keymap.set('n', '<S-k>', function() hover.open() end, { desc = "Hover: Open" })
        vim.keymap.set('n', '<leader><S-k>', function() hover.enter() end, { desc = "Hover: Enter" })
        vim.keymap.set('n', '<C-p>', function() hover.switch('previous') end, { desc = "Hover: Previous" })
        vim.keymap.set('n', '<C-n>', function() hover.switch('next') end, { desc = "Hover: Next" })
    end
}
