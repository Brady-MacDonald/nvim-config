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
        build = function() require('blink.pairs').download():pwait(60000) end,
        dependencies = { 'rafamadriz/friendly-snippets', "giuxtaposition/blink-cmp-copilot" },
        version = '1.*',
        event = "InsertEnter",
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
                    ['<C-k>'] = { 'accept', 'fallback' },
                    ['<C-j>'] = { 'show_signature', 'hide_signature', 'fallback' },
                },

                signature = { enabled = true },

                completion = {
                    menu = {
                        draw = {
                            columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
                            treesitter = { "lsp" },
                        },
                    },
                    documentation = {
                        auto_show = true,
                        auto_show_delay_ms = 300,
                    },
                },

                sources = {
                    default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
                    providers = {
                        copilot = {
                            name = "copilot",
                            module = "blink-cmp-copilot",
                            score_offset = 100,
                            async = true,
                        },
                    },
                },

                snippets = {
                    preset = 'luasnip'
                }
            })
        end
    }
}
