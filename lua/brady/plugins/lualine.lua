return {
    "nvim-lualine/lualine.nvim",
    event = "BufReadPre",
    config = function()
        -- Show macro recording in lualine
        local function macro_flag()
            local reg = vim.fn.reg_recording()
            if reg ~= "" then
                return "MACRO @" .. reg:upper()
            end

            local mode = vim.api.nvim_get_mode().mode
            local mode_map = {
                n = "NORMAL",
                i = "INSERT",
                v = "VISUAL",
                V = "V-LINE",
                ["\22"] = "V-BLOCK",
                c = "COMMAND",
                R = "REPLACE",
                s = "SELECT",
                S = "S-LINE",
                t = "TERMINAL",
            }

            return mode_map[mode] or mode:upper()
        end

        -- Change color based on mode
        local function mode_color()
            local mode_colors = {
                n = "#7aa2f7",       -- blue
                i = "#9ece6a",       -- green
                v = "#bb9af7",       -- purple
                V = "#bb9af7",
                ["\22"] = "#bb9af7", -- CTRL-V
                c = "#e0af68",       -- yellow
                R = "#f7768e",       -- red
                s = "#7dcfff",       -- cyan
                S = "#7dcfff",
                t = "#f7768e",
            }
            local mode = vim.api.nvim_get_mode().mode
            return { fg = mode_colors[mode] or "#c0caf5", bg = "NONE", gui = "bold" }
        end

        require("lualine").setup({
            options = {
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                always_divide_middle = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = { {
                    macro_flag,
                    color = mode_color
                } },
                lualine_b = { "branch", "diff", "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { 'filename' },
                lualine_x = { 'location' },
                lualine_y = {},
                lualine_z = {}
            },
        })

        Transparent_statusline()
    end
}
