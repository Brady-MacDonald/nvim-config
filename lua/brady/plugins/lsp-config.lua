--------------------------
-- LSP Config
--------------------------

return {
    -- Mason: manages external Neovim dependencies
    -- Downloads the LSP to local machine (using git or npm)
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },

    -- Mason-LspConfig: bridge between mason.nvim <-> nvim-lspconfig
    -- Allows to set default LSP's to always have installed (config as code)
    -- Name of language server must be agreed upon mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "tsserver", "lua_ls", "jsonls", "gopls" },
            }
        end
    },

    -- Configure the lua_ls for vim api docs
    { "folke/neodev.nvim" },

    -- nvim-lspconfig: Used by builtin LSP client for server startup configuration
    -- Has pre-made configurations needed to start most common language servers
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("neodev").setup()

            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            -- Can define custom 'handlers' when configuring each LS
            -- By specifying the LSP method, handler = {["textDocument/method"] = function() ... end}
            -- This handler will be invoked once the LS sends its response
            -- This will configure the handler for the lsp-method for just the given server

            lspconfig.tsserver.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.pylsp.setup({})
            lspconfig.volar.setup({})
            lspconfig.cssls.setup({})
            lspconfig.html.setup({
                filetypes = { "html", "template" }
            })

            lspconfig.gopls.setup {
                -- on_attach = lspconfig.on_attach,
                -- add in the nvim-cmp completion ca[ability]
                -- capabilities = lspconfig.capabilities,
                cmd = { "gopls" },
                filetypes = { "go", "gomod", "gowork", "gotmpl" },
                root_dir = util.root_pattern("go.work", "go.mod", ".git"),
                settings = {
                    gopls = {
                        completeUnimported = true,
                        usePlaceholders = true,
                        analyses = {
                            unusedparams = true,
                        },
                    },
                },
            }

            lspconfig.lua_ls.setup {
                handlers = {
                    ["textDocument/hover"] = function(err, result, ctx, config)
                        if err ~= nil then
                            vim.notify(vim.json.encode(err), "error", { title = "LSP hover Error" })
                        end

                        vim.lsp.handlers["textDocument/hover"](err, result, ctx, config)
                    end
                }
            }

            -- Global Diagnostic Mappings
            vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = "Diagnostic: Open" })
            vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = "Diagnostic: Previous" })
            vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = "Diagnostic: Next" })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Create buffer scoped LSP keymaps when LSP attaches to buffer",
                group = vim.api.nvim_create_augroup("LspKeymaps", {}),
                callback = function(event_data)
                    vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover,
                        { desc = "LSP: textDocument/hover", buffer = 0 })
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
                        { desc = "LSP: textDocument/codeactions", buffer = 0 })
                    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition,
                        { desc = "LSP: textDocument/definition", buffer = 0 })
                    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition,
                        { desc = "LSP: textDocument/typeDefinition", buffer = 0 })
                    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation,
                        { desc = "LSP: textDocument/implementation", buffer = 0 })
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename,
                        { desc = "LSP: textDocument/rename", buffer = 0 })
                    vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format,
                        { desc = "LSP: textDocument/formatting", buffer = 0 })

                    -- Telescope LSP commands
                    local telescope_builtin = require("telescope.builtin")
                    vim.keymap.set('n', '<leader>fr', telescope_builtin.lsp_references,
                        { desc = "Telescope: textDocument/references", buffer = 0 })
                    vim.keymap.set('n', '<leader>td', telescope_builtin.diagnostics,
                        { desc = "Telescope: textDocument/diagnostics", buffer = 0 })
                    vim.keymap.set("n", "<leader>ds", telescope_builtin.lsp_document_symbols,
                        { desc = "Telescope: textDocument/symbols", buffer = 0 })
                    vim.keymap.set("n", "<leader>ws", telescope_builtin.lsp_workspace_symbols,
                        { desc = "Telescope: workSpace/symbols", buffer = 0 })

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        desc = "textDocument/formatting Request on BufWritePre",
                        group = vim.api.nvim_create_augroup("LspFormatPreWrite", {}),
                        callback = function(ev)
                            local sbr_betpoints = string.find(ev.match, "/sbr/betpoints")
                            local sbr_directus = string.find(ev.match, "/sbr/directus")
                            local sbr_odds = string.find(ev.match, "/sbr/odds")

                            local not_sbr = sbr_betpoints == nil and sbr_directus == nil and sbr_odds == nil

                            local buf_clients = vim.lsp.get_clients({ bufnr = ev.buf })
                            if not_sbr and #buf_clients ~= 0 and buf_clients[1].server_capabilities.documentFormattingProvider then
                                vim.lsp.buf.format()
                            end
                        end
                    })
                end
            })
        end
    }
}
