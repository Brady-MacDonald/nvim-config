vim.keymap.set({ "i", "n" }, "<leader>jk", "<escape>")
vim.keymap.set("t", "<leader>jk", "<C-\\><C-n>")

vim.keymap.set("t", "<C-w>c", "<C-\\><C-n><C-w>c<C-w>l")

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set('n', '<leader>o', 'o<escape>')
vim.keymap.set('n', '<leader>O', 'O<escape>')

-- Control the size of splits (height/width)
vim.keymap.set("n", "<C-w>,", "<c-w>5<")
vim.keymap.set("n", "<C-w>.", "<c-w>5>")

-- vim.keymap.set("n", "<M-,>", "<c-w>5<")
-- vim.keymap.set("n", "<M-.>", "<c-w>5>")
-- vim.keymap.set("n", "<M-t>", "<C-W>+")
-- vim.keymap.set("n", "<M-s>", "<C-W>-")

vim.keymap.set("n", "<leader><leader>x", "<cmd>w<CR><cmd>source %<CR>", { desc = "Exec file" })
vim.keymap.set("n", "<leader>x", ":.lua<CR>", { desc = "Exec line" })
vim.keymap.set("v", "<leader>x", ":lua<CR>", { desc = "Exec visual selection" })

vim.keymap.set("x", "<leader>vp", '"_dP', { desc = "Void: Paste" })
vim.keymap.set("x", "<leader>vd", '"_d', { desc = "Void: Delete" })

vim.keymap.set('n', '<leader>nh', '<cmd>nohlsearch<CR>', { desc = "No Highlight" })
vim.keymap.set('n', '<leader>sp', "<cmd>lua vim.opt.spell = not vim.opt.spell:get()<CR>", { desc = "Toggle spelling" })

vim.keymap.set("n", "<leader>af", "<cmd>e#<CR>", { desc = "Alternate File" })
vim.keymap.set({ "n", "v" }, "<leader>m", "<S-%>", { desc = "Match Parenthesis" })

vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Buffer: Next" })
vim.keymap.set("n", "<leader>bb", "<cmd>bprev<CR>", { desc = "Buffer: Back" })
vim.keymap.set("n", "<leader>bd", "<cmd>bnext<CR><cmd>bd#<CR>", { desc = "Buffer: Delete" })

vim.keymap.set('n', '<C-j>', '<cmd>cnext<CR>', { desc = "QuickfixList :cnext" })
vim.keymap.set('n', '<C-k>', '<cmd>cprev<CR>', { desc = "QuickfixList :cprev" })
vim.keymap.set('n', '<C-c>', '<cmd>cclose<CR>', { desc = "QuickfixList :cclose" })
vim.keymap.set('n', '<leader><c-o>', '<cmd>copen<cr>', { desc = "quickfixlist :copen" })

vim.keymap.set('n', '<leader>cf', "<cmd>cd %:p:h | pwd <CR>", { desc = "cd into current files directory" })
vim.keymap.set('n', '<leader>cd', function()
    local function get_ft_root(ft)
        local root = require("lspconfig.util")

        if ft == "lua" then
            return root.root_pattern(".git", "init.lua")
        elseif ft == "go" then
            return root.root_pattern(".git", "go.mod")
        elseif ft == "typescript" or ft == "javascript" then
            return root.root_pattern(".git", "package.json")

            -- Check for .git directory
        else
            vim.notify("No root dir found for filetype: " .. ft)
        end
    end

    local ft = vim.bo.filetype
    local path = vim.fn.expand("%:p:h")

    local ft_root = get_ft_root(ft)
    local cwd = ft_root(path)

    vim.cmd("cd " .. cwd)
    vim.cmd("pwd")
end, { desc = "cd into project root" })

vim.keymap.set("n", "<leader>df", function()
    local format = vim.g.format
    if format then
        vim.notify("Disabled: Formatting on save")
    else
        vim.notify("Enabled: Formatting on save")
    end

    vim.g.format = not format
end, { desc = "Toggle formatting on save" })

vim.keymap.set('n', '[o', vim.diagnostic.open_float, { desc = "Diagnostics: Open" })
vim.keymap.set("n", "<leader>dd", function()
    local diag = vim.diagnostic.is_enabled()
    vim.diagnostic.enable(not diag)
end, { desc = "Diagnostics: Toggle" })

vim.keymap.set("n", "<leader><leader>sbr", function()
    require("sbr").setup()
end, { desc = "Set up SBR config" })

vim.keymap.set("n", "<leader><leader>mo", function()
    require("brady.monk").setup()
end, { desc = "Set up Monk LSP" })

vim.keymap.set("n", "<leader><leader>c", function()
    local color_scheme = vim.fn.input("Colorscheme: ")
    local theme_picker = require("brady.themes")
    local colors = theme_picker.get_theme(color_scheme)
    theme_picker.apply_themes(colors)
end, { desc = "COLORS" })

vim.keymap.set("n", "<leader>at", function()
    local ext = vim.fn.expand("%:e")
    if ext ~= "go" then
        return print("Not a go file...")
    end

    local file = vim.fn.expand("%:p:r")
    local is_test_file = string.match(file, "_test$")

    local target_file = file .. "_test.go"
    if is_test_file then
        target_file = string.gsub(file, "_test$", ".go")
    end

    if vim.fn.filereadable(target_file) == 1 then
        local file_path = vim.split(target_file, "/")
        print("Opening -> " .. file_path[#file_path])
        vim.cmd("e " .. target_file)
    else
        print("File does not exist: " .. target_file)
    end
end, { desc = "Alternate Test: for go projects" })
