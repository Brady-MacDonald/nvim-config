return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                css = { "prettier" },
                scss = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                jsonc = { "prettier" },
                yaml = { "prettier" },
                -- Other languages fall back to LSP formatting
            },
            format_on_save = function()
                if not vim.g.format then
                    return nil
                end
                return {
                    lsp_fallback = true,
                    timeout_ms = 500,
                }
            end,
        })

        -- Override the LSP format keymap to use conform instead
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("ConformLspFormat", { clear = true }),
            callback = function(args)
                vim.keymap.set("n", "<leader>fm", function()
                    conform.format({
                        lsp_fallback = true,
                        timeout_ms = 500,
                    })
                end, { desc = "Format buffer (Conform)", buffer = args.buf })
            end,
        })
    end,
}
