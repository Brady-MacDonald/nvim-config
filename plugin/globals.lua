-- Global Functions

P = function(t)
    print(vim.inspect(t))
    return t
end

MP = function(t)
    print(vim.inspect(getmetatable(t)))
    return t
end

vim.filetype.add({
    -- Detect and assign filetype based on the extension of the filename
    extension = {
        mdx = "mdx",
        log = "log",
        conf = "conf",
    },

    -- Detect and apply filetypes based on the entire filename
    filename = {
        [".env"] = "sh",
        ["env"] = "sh",
    },

    -- Detect and apply filetypes based on certain patterns of the filenames
    pattern = {
        -- Match filenames like - ".env.staging", ".env.local" ...
        ["%.env%.[%w_.-]+"] = "sh",
    },
})
