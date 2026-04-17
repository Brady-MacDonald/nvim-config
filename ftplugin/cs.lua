-- C# specific settings
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

-- Enable code folding
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldenable = false -- Start with folds open

-- Improve syntax highlighting stability
vim.opt_local.synmaxcol = 500 -- Limit syntax highlighting to 500 columns (prevents slowdown on long lines)
vim.opt_local.redrawtime = 10000 -- Increase redraw timeout for complex files
