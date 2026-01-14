vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup("HighlightYank", {}),
    callback = function()
        vim.hl.on_yank({
            higroup = "IncSearch",
            timeout = 100,
        })
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("VueCommentString", {}),
    desc = "Comment string for Vue files",
    pattern = "vue",
    callback = function()
        vim.bo.commentstring = "<!-- %s -->"
    end
})
