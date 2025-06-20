--------------------------
-- LSP Config
--------------------------
return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonLog", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
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
                ensure_installed = { "clangd", "lua_ls", "gopls" },
            }
        end
    },

    -- Configure the lua_ls for the vim api
    { "folke/lazydev.nvim" },

    -- nvim-lspconfig: Used by lsp startup config
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            require("lazydev").setup()

            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            -- Can define custom 'handlers' when configuring each LS
            -- By specifying the LSP method, handler = {["textDocument/method"] = function() ... end}
            -- This handler will be invoked once the LS sends its response
            -- This will configure the handler for the lsp-method for just the given server

            lspconfig.arduino_language_server.setup({})

            lspconfig.clangd.setup({})
            lspconfig.lua_ls.setup({})
            lspconfig.ts_ls.setup({})
            lspconfig.jsonls.setup({})
            lspconfig.pylsp.setup({})
            lspconfig.bashls.setup({})
            lspconfig.dockerls.setup({})
            lspconfig.volar.setup {
                filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                init_options = {
                    vue = {
                        hybridMode = false,
                    },
                },
            }

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


            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Create buffer scoped LSP keymaps when LSP attaches to buffer",
                group = vim.api.nvim_create_augroup("LspKeymaps", {}),
                callback = function()
                    -- Defaults in nvim 0.11
                    vim.keymap.set('n', 'grn', vim.lsp.buf.rename,
                        { desc = "LSP: textDocument/rename", buffer = 0 })
                    vim.keymap.set('n', 'grr', vim.lsp.buf.references,
                        { desc = "LSP: textDocument/references", buffer = 0 })
                    vim.keymap.set('n', 'gra', vim.lsp.buf.code_action,
                        { desc = "LSP: textDocument/codeactions", buffer = 0 })
                    vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help,
                        { desc = "LSP: textDocument/signatureHelp", buffer = 0 })

                    vim.keymap.set('i', '<C-h>', vim.lsp.buf.code_action,
                        { desc = "LSP: textDocument/codeactions", buffer = 0 })
                    vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover,
                        { desc = "LSP: textDocument/hover", buffer = 0 })
                    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition,
                        { desc = "LSP: textDocument/definition", buffer = 0 })
                    vim.keymap.set('n', '<leader>gt', vim.lsp.buf.type_definition,
                        { desc = "LSP: textDocument/typeDefinition", buffer = 0 })
                    vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation,
                        { desc = "LSP: textDocument/implementation", buffer = 0 })
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
                    vim.keymap.set("n", "<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols,
                        { desc = "Telescope: workSpace/dynamic_symbols", buffer = 0 })
                    vim.keymap.set("n", "<leader>ls", telescope_builtin.lsp_workspace_symbols,
                        { desc = "Telescope: workSpace/symbols", buffer = 0 })

                    vim.api.nvim_create_autocmd("BufWritePre", {
                        desc = "textDocument/formatting Request on BufWritePre",
                        group = vim.api.nvim_create_augroup("LspFormatPreWrite", {}),
                        callback = function(ev)
                            local format = vim.g.format

                            local buf_clients = vim.lsp.get_clients({ bufnr = ev.buf })
                            if format and #buf_clients ~= 0 and buf_clients[1].server_capabilities.documentFormattingProvider then
                                vim.lsp.buf.format()
                            end
                        end
                    })
                end
            })
        end
    },
    {
        "jmederosalvarado/roslyn.nvim",
        event = "VeryLazy",
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            require("roslyn").setup({
                capabilities = capabilities,
                on_attach = function() end,
            })
        end
    }
}
