-- CSHTML/Razor specific settings
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

-- Set commentstring for razor files
vim.bo.commentstring = "@* %s *@"

-- Improve syntax highlighting stability for mixed HTML/C# content
vim.opt_local.synmaxcol = 500 -- Limit syntax highlighting per line
vim.opt_local.redrawtime = 10000 -- Increase redraw timeout

-- Force proper syntax loading
vim.cmd([[
    runtime! syntax/html.vim
    runtime! syntax/razor.vim
]])

-- Disable treesitter for cshtml to avoid conflicts with vim-razor
vim.b.ts_highlight = false
