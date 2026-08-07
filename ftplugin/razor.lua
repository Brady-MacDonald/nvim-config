-- Razor/CSHTML specific settings (both *.cshtml and *.razor get filetype "razor")
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

-- Improve syntax highlighting stability for mixed HTML/C# content
vim.opt_local.synmaxcol = 500 -- Limit syntax highlighting per line
vim.opt_local.redrawtime = 10000 -- Increase redraw timeout

-- commentstring is provided by vim-razor's ftplugin/razor.vim (@* %s *@)
