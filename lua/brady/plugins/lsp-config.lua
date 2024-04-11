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
    -- Allows to set default LSP's to always have intalled (config as code)
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "tsserver", "lua_ls", "jsonls", "gopls" },
            }
        end
    },

    -- Nvim-LspConfig: Used by the built in neovim LSP client for configuration
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local util = require("lspconfig.util")

            -- Can define custom 'handlers' when configuring each LSP
            -- By specifying the LSP method, handler = {["textDocument/method"] = function() ... end}
            -- This handler will be envoked once the LS sends its response
            -- This will configure the handler for the lsp-method for just the given server
            -- We can then intercept, the response and provide additional config, then call the builtin NVIM handler

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

                        vim.notify(vim.json.encode(result), "result", { title = "LSP hover" })
                        vim.lsp.handlers["textDocument/hover"](err, result, ctx, config)
                    end
                }
            }


            -- Global Diagnostic Mappings
            vim.keymap.set('n', '<leader>do', vim.diagnostic.open_float, { desc = "Diagnostic: Open" })
            vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev, { desc = "Diagnostic: Previous" })
            vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next, { desc = "Diagnostic: Next" })

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Create kepmaps for LSP commands when Lsp attaches to buffer",
                group = vim.api.nvim_create_augroup("LspKeymaps", {}),
                callback = function(event_data)
                    vim.keymap.set('n', '<S-k>', vim.lsp.buf.hover, {})
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
                    vim.keymap.set('n', '<leader>gd', vim.lsp.buf.definition, {})
                    vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, {})
                    vim.keymap.set('n', '<leader>td', vim.lsp.buf.type_definition, {})
                    vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, {})

                    -- Telescope LSP commands
                    local telescope = require("telescope.builtin")

                    vim.keymap.set('n', '<leader>fr', telescope.lsp_references,
                        { desc = "Telescope: textDocument/references" })
                    vim.keymap.set("n", "<leader>ds", telescope.lsp_document_symbols,
                        { desc = "Telescope: textDocument/symbols" })
                    vim.keymap.set("n", "<leader>ws", telescope.lsp_workspace_symbols,
                        { desc = "Telescope: workSpace/symbols" })

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
