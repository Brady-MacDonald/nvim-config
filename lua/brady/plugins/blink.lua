return {
    'saghen/blink.cmp',
    build = function() require('blink.pairs').download():pwait(60000) end,
    dependencies = { 'rafamadriz/friendly-snippets', "L3MON4D3/LuaSnip" },
    version = '1.*',
    event = "InsertEnter",
    config = function()
        require('blink.cmp').setup({
            -- C-space: Open menu or open docs if already open
            -- C-e: Hide menu
            -- C-k: Accept selection
            -- C-j: Toggle signature help
            keymap = {
                preset = 'default',
                ['<C-k>'] = { 'accept', 'fallback' },
                ['<C-j>'] = { 'show_signature', 'hide_signature', 'fallback' },
            },
            signature = { enabled = true },
            completion = {
                keyword = { range = 'full' },
                menu = {
                    draw = {
                        columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
                        treesitter = { "lsp" },
                        components = {
                            kind_icon = {
                                highlight = function(ctx) return { { group = ctx.kind_hl, priority = 20000 } } end,
                            },
                        },
                    },
                },
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 300,
                },
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
                -- Show LSP/buffer completions in opencode.nvim's Ask input
                per_filetype = {
                    opencode_ask = { 'lsp', 'buffer' },
                },
                providers = {
                    -- Display buffer completions when no LSP completions are available
                    lsp = { fallbacks = {} },
                },
            },
            snippets = {
                preset = 'luasnip'
            }
        })
    end
}
