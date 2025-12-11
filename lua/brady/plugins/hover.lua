return {
    "lewis6991/hover.nvim",
    config = function()
        local hover = require('hover')

        hover.config({
            mouse_providers = {},
            providers = {
                'hover.providers.diagnostic',
                'hover.providers.lsp',
                'hover.providers.dap',
                'hover.providers.man',
                'hover.providers.dictionary',
                -- Optional, disabled by default:
                -- 'hover.providers.gh',
                -- 'hover.providers.gh_user',
                -- 'hover.providers.jira',
                -- 'hover.providers.fold_preview',
                -- 'hover.providers.highlight',
            },
            preview_opts = { border = 'single' },
            preview_window = false,
            title = true,
        })

        vim.keymap.set('n', 'K', function() hover.open() end, { desc = 'hover.nvim (open)' })
        vim.keymap.set('n', 'gK', function() hover.enter() end, { desc = 'hover.nvim (enter)' })
        vim.keymap.set('n', '<C-p>', function() hover.switch('previous') end, { desc = 'hover.nvim (previous source)' })
        vim.keymap.set('n', '<C-n>', function() hover.switch('next') end, { desc = 'hover.nvim (next source)' })
    end
}
