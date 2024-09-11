local M = {}

---@class colors_pal
---@field type string

---Get the color pallet
---@param name string
---@return colors_pal
M.get_theme = function(name)
    local theme = "brady.themes.colors." .. name
    local colors = require(theme)
    return colors
end

M.apply_themes = function(colors)
    local plugs = {
        "telescope",
        "cmp",
        "treesitter"
    }

    for _, hl in ipairs(plugs) do
        local plugin = "brady.themes.highlights." .. hl
        vim.notify(plugin)
        local plugin_highlight_groups = require(plugin).get_highlight_groups(colors)

        for hl, val in pairs(plugin_highlight_groups) do
            vim.api.nvim_set_hl(0, hl, val)
        end
    end
end

M.apply_theme = function()

end

return M
