local pwd = vim.fn.getcwd()

local no_format_dirs = {
    "/sportsbookreview/",
    "/nssmp/",
}

local format_on_save = nil
for _, dirs in ipairs(no_format_dirs) do
    format_on_save = string.find(pwd, dirs)
end

if format_on_save == nil then
    vim.g.format = true
else
    vim.g.format = false
end
