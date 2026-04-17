vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 10

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.winborder = "rounded"
vim.diagnostic.config({ virtual_text = { current_line = true } })

vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.opt.swapfile = false

-- Syntax highlighting performance and stability
vim.opt.redrawtime = 10000 -- Increase timeout for syntax highlighting (default 2000)
vim.opt.synmaxcol = 500 -- Only highlight first 500 columns (prevents issues with long lines)
