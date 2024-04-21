vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup("HighlightYank", {}),
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 80,
        })
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "LSP code_actions request to auto format imports on save",
    group = vim.api.nvim_create_augroup("FormatGoImports", {}),
    pattern = "*.go",
    callback = function(ev)
        local params = vim.lsp.util.make_range_params()
        vim.lsp.buf_request(0, "textDocument/codeAction", params, function(err, res, ctx, config)
            if err ~= nil then return end
            if res == nil then return end

            local organize_imports = {}
            for _, code_action in pairs(res) do
                if code_action.kind == "source.organizeImports" then
                    organize_imports = code_action
                end
            end

            if #organize_imports.edit.documentChanges == 0 then return end

            vim.lsp.util.apply_text_edits(organize_imports.edit.documentChanges[1].edits, ev.buf, "utf-8")
        end)
    end
})
