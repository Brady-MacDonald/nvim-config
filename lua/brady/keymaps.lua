vim.keymap.set('i', '<leader>jk', '<escape>')
vim.keymap.set('v', '<leader>jk', '<escape>')
vim.keymap.set("t", "<leader>jk", "<C-\\><C-n>")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>o', 'o<escape>')
vim.keymap.set('n', '<leader>O', 'O<escape>')

vim.keymap.set('n', '<leader>nh', '<cmd>nohlsearch<CR>', { desc = "No Highlight" })

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "BufferNext" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "BufferPrev" })
vim.keymap.set("n", "<leader>bd", "<cmd>bnext<CR><cmd>bd#<CR>", { desc = "BufferDelete" })

vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>', { desc = "QuickfixList :cnext" })
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>', { desc = "QuickfixList :cprev" })
vim.keymap.set('n', '<C-c>', '<cmd>cclose<CR>', { desc = "QuickfixList :cclose" })

vim.keymap.set("n", "<leader><leader>x", "<cmd>w<CR><cmd>so<CR>")

vim.keymap.set("n", "<leader><leader>d", function()
    print("clearing")
    package.loaded["directus"] = nil
    package.loaded["directus.api"] = nil
    package.loaded["directus.filter"] = nil
    package.loaded["directus.utils"] = nil
end)

-- Git Restore File
vim.keymap.set('n', '<leader>grf', function()
    local file = vim.fn.expand("%")
    io.popen("git restore " .. file)
end
, { desc = "git restore file" })

-- Git Restore
vim.keymap.set('n', '<leader>gr', function()
    io.popen("git restore .")
end, { desc = "git restore ." })

vim.keymap.set("n", "<leader><leader>sbr", function()
    require("sbr").setup()
end, { desc = "Set up SBR config" })

vim.keymap.set("n", "<leader><leader>mo", function()
    require("brady.monk").setup()
end, { desc = "Set up Monk LSP" })
