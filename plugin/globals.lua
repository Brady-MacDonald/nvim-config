-- ./plugin folder is automatically executed on NeoVIM startup

-- Global Functions

P = function(t)
    print(vim.inspect(t))
    return t
end

MP = function(t)
    print(vim.inspect(getmetatable(t)))
    return t
end
