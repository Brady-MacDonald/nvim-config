return {
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-nvim-lsp" }, -- Auto imports
    { "onsails/lspkind-nvim" }, -- Icons for completions

    -- used as a source to be used by nvim-cmp
    -- Can create our own snippets for this plugin to be used
    {
        "L3MON4D3/LuaSnip",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local ls = require("luasnip")

            vim.keymap.set('i', '<C-k>', function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { desc = "Expand snippet" })

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

            lspkind.init()

            vim.opt.completeopt = { "menu", "menuone", "noselect" }
            vim.opt.shortmess:append "c"

            cmp.setup({
                sources = {
                    { name = "luasnip" },
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                },

                -- Setting up mapping
                mapping = {
                    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    ["<C-k>"] = cmp.mapping(
                        cmp.mapping.confirm {
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true,
                        },
                        { "i", "c" }
                    ),
                },

                -- luasnip to handle snippet expansion
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },

                -- Format sources
                formatting = {
                    ---@diagnostic disable-next-line: missing-fields
                    format = lspkind.cmp_format {
                        with_text = true,
                        menu = {
                            luasnip = "[SNIP]",
                            nvim_lsp = "[LSP]",
                            buffer = "[BUF]",
                            path = "[PATH]",
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
