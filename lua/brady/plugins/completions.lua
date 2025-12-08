return {
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        config = function()
            local ls = require("luasnip")

            vim.keymap.set('i', '<C-k>', function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { desc = "Expand snippet" })
        end,
    },
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        config = function()
            local blink = require('blink.cmp')

            blink.setup({

                -- C-space: Open menu or open docs if already open
                -- C-e: Hide menu
                -- C-k: Toggle signature help (if signature.enabled = true)
                --
                -- See :h blink-cmp-config-keymap for defining your own keymap
                keymap = {
                    preset = 'default',
                    ['<C-k>'] = { 'select_and_accept', 'fallback' },
                    ['<C-j>'] = { 'show_signature', 'hide_signature', 'fallback' },
                },

                signature = { enabled = true },

                completion = {
                    menu = {
                        draw = {
                            treesitter = { "lsp" },
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 300,
                    },
                },

                -- Default list of enabled providers defined so that you can extend it
                -- elsewhere in your config, without redefining it, due to `opts_extend`
                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer' },
                },

                snippets = {
                    preset = 'luasnip'
                }
            })
        end
    }
}
