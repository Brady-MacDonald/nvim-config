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
