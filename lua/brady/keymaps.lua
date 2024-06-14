vim.keymap.set({ "i", "n" }, "<leader>jk", "<escape>")
vim.keymap.set("t", "<leader>jk", "<C-\\><C-n>")

vim.keymap.set("t", "<C-w>c", "<C-\\><C-n><C-w>c<C-w>l")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>o', 'o<escape>')
vim.keymap.set('n', '<leader>O', 'O<escape>')

vim.keymap.set('n', '<leader>nh', '<cmd>nohlsearch<CR>', { desc = "No Highlight" })
vim.keymap.set('n', '<leader>sp', "<cmd>lua vim.opt.spell = not vim.opt.spell:get()<CR>", { desc = "Toggle spelling" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>w<CR><cmd>so<CR>", { desc = "Exec file" })

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "BufferNext" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "BufferPrev" })
vim.keymap.set("n", "<leader>bd", "<cmd>bnext<CR><cmd>bd#<CR>", { desc = "BufferDelete" })

vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>', { desc = "QuickfixList :cnext" })
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>', { desc = "QuickfixList :cprev" })
vim.keymap.set('n', '<C-c>', '<cmd>cclose<CR>', { desc = "QuickfixList :cclose" })

-- Control the size of splits (height/width)
vim.keymap.set("n", "<M-,>", "<c-w>5<")
vim.keymap.set("n", "<M-.>", "<c-w>5>")
vim.keymap.set("n", "<M-t>", "<C-W>+")
vim.keymap.set("n", "<M-s>", "<C-W>-")

-- Diagnostics
vim.keymap.set('n', '[o', vim.diagnostic.open_float, { desc = "Diagnostic: Open" })
vim.keymap.set("n", "<leader>dd", function()
    local diag = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not diag)
end, { desc = "Toggle Diagnostics" })

-- Git Restore File
vim.keymap.set('n', '<leader>grf', function()
    local file = vim.fn.expand("%")
    io.popen("git restore " .. file)
end, { desc = "Git: Restore %" })

vim.keymap.set("n", "<leader><leader>d", function()
    print("clearing")
    package.loaded["directus"] = nil
    package.loaded["directus.api"] = nil
    package.loaded["directus.filter"] = nil
    package.loaded["directus.utils"] = nil
end)

vim.keymap.set("n", "<leader><leader>sbr", function()
    require("sbr").setup()
end, { desc = "Set up SBR config" })

vim.keymap.set("n", "<leader><leader>mo", function()
    require("brady.monk").setup()
end, { desc = "Set up Monk LSP" })
