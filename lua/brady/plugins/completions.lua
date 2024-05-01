return {
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-nvim-lsp" }, -- Auto imports
    { "onsails/lspkind-nvim" },

    -- used as a source to be used by nvim-cmp
    -- Can create our own snippets for this plugin to be used
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load() -- friendly-snippets loader
            local ls = require("luasnip")

            vim.keymap.set('i', '<C-k>', function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, {})

            vim.keymap.set('i', '<C-j>', function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, {})
        end,
    },

    -- Needs actual completion sources
    -- Can add many different completion sources
    -- Can make our own completion source even
    -- nvim-cmp is the completion engine that reaches out to the various sources
    {
        "hrsh7th/nvim-cmp",
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                -- Snippet plugin for the snippet engineto??
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                -- Setting up mapping
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Apply the sugested completion
                }),

                -- Set completion sources for nvim-cmp
                -- Order of sources sets the priority
                -- sources = cmp.config.sources({
                --     { name = "luasnip" },
                --     { name = "nvim_lua", max_item_count = 5 },
                --     { name = "nvim_lsp", max_item_count = 5 },
                -- }),

                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                }, {
                    { name = "gh_issues" },
                }),

                -- Format sources
                formatting = {
                    format = lspkind.cmp_format {
                        with_text = true,
                        menu = {
                            nvim_lsp = "[LSP]",
                            luasnip = "[SNIP]",
                            buffer = "[BUF]",
                            gh_issues = "[GH_ISS]"
                        },
                    },
                },

                -- Style for the window
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end,
    },
}
