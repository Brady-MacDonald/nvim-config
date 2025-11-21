return {
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonLog", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "clangd", "lua_ls", "gopls" },
            }
        end
    },
    {
        "folke/lazydev.nvim"
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        config = function()
            require("lazydev").setup()

            -- Can define custom 'handlers' when configuring each LS
            -- By specifying the LSP method, handler = {["textDocument/method"] = function() ... end}
            -- This handler will be invoked once the LS sends its response
            -- This will configure the handler for the lsp-method for just the given server

            vim.lsp.enable("lua_ls")
            vim.lsp.enable("clangd")
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("jsonls")
            vim.lsp.enable("pylsp")
            vim.lsp.enable("bashls")
            vim.lsp.enable("dockerls")
            vim.lsp.enable("cssls")
            vim.lsp.enable("html")

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Create buffer scoped LSP keymaps when LSP attaches to buffer",
                group = vim.api.nvim_create_augroup("LspKeymaps", {}),
                callback = function()
                    vim.keymap.set('i', '<C-h>', vim.lsp.buf.code_action,
                        { desc = "LSP: textDocument/codeactions", buffer = 0 })
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
