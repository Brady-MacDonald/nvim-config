-- Global Functions

---Global function to print vim.inspect() info
---@param t any
---@return any
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
        mdx = "markdown",
        log = "log",
        conf = "conf",
        monk = "monk",
    },

    -- Apply filetype based on the entire file name
    filename = {
        [".env"] = "sh",
        ["env"] = "sh",
        ["config"] = "sh",
    },

    -- Pattern matching for filetype
    pattern = {
        -- ".env.staging", ".env.local" ...
        ["%.env%.[%w_.-]+"] = "sh",
    },
})

-- Enforce transparency for status line highlight groups
Transparent_statusline = function()
    local groups = { "StatusLine", "StatusLineNC", "WinBar", "WinBarNC", }
    for _, hl in ipairs(groups) do
        vim.api.nvim_set_hl(0, hl, { bg = "NONE" })
    end

    for _, mode in ipairs({ "normal", "insert", "visual", "replace", "command", "inactive", }) do
        for _, section in ipairs({ "a", "b", "c" }) do
            vim.api.nvim_set_hl(0, string.format("lualine_%s_%s", section, mode), { bg = "NONE" })
        end
    end
end

Transparent_statusline()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = Transparent_statusline,
})
