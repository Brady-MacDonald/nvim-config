-- Global Functions

P = function(t)
    print(vim.inspect(t))
    return t
end

MP = function(t)
    print(vim.inspect(getmetatable(t)))
    return t
end

NP = function(t)
    vim.notify(vim.inspect(t))
    return t
end

vim.filetype.add({
    -- Assign filetype based on the extension
    extension = {
        mdx = "mdx",
        log = "log",
        conf = "conf",
        monk = "monk",
    },

    -- Apply filetype based on the entire file name
    filename = {
        [".env"] = "sh",
        ["env"] = "sh",
    },

    -- Pattern matching for filetype
    pattern = {
        -- ".env.staging", ".env.local" ...
        ["%.env%.[%w_.-]+"] = "sh",
    },
})

vim.api.nvim_create_autocmd("filetype", {
    group = vim.api.nvim_create_augroup("VueCommentString", {}),
    desc = "Comment string for Vue files",
    pattern = "vue",
    callback = function()
        vim.bo.commentstring = "<!-- %s -->"
    end
})
