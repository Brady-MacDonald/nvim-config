return {
    {
        "iabdelkareem/csharp.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
            "jay-babu/mason-nvim-dap.nvim",
            "Tastyep/structlog.nvim",
        },
        ft = { "cs" },
        config = function()
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
        -- Loaded eagerly so syntax/razor.vim is on the runtimepath before
        -- the FileType "razor" event fires. If lazy-loaded on `ft`, the
        -- syntax file is not yet available when Vim sets syntax=razor and
        -- no highlighting is applied (white page).
        "jlcrochet/vim-razor",
        lazy = false,
    },
}
