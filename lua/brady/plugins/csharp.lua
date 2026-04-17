return {
    {
        "iabdelkareem/csharp.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "Tastyep/structlog.nvim",
        },
        ft = { "cs" },
        config = function()
            require("mason").setup()
            require("csharp").setup({
                lsp = {
                    -- Omnisharp settings
                    enable_editor_config_support = true,
                    organize_imports_on_format = true,
                    enable_import_completion = true,
                    enable_roslyn_analyzers = true,
                    analyze_open_documents_only = false,
                },
                dap = {
                    -- DAP adapter name from nvim-dap
                    adapter_name = "coreclr",
                },
            })
        end,
    },
    {
        "jlcrochet/vim-razor",
        ft = { "razor", "cshtml" },
        config = function()
            -- Ensure proper filetype detection
            vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                pattern = { "*.cshtml", "*.razor" },
                callback = function()
                    vim.bo.filetype = "html.cshtml.razor"
                end,
            })
        end,
    },
}
