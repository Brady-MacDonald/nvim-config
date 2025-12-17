return {
    "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    event = "BufReadPost",
    config = function()
        require('lualine').setup({
            options = {
                -- theme = 'catppuccin',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                always_divide_middle = true,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {
                    function()
                        -- If a macro is being recorded, show "Recording @<register>"
                        local reg = vim.fn.reg_recording()
                        if reg ~= "" then
                            return "MACRO @" .. reg:upper()
                        end

                        local mode = vim.api.nvim_get_mode().mode
                        local mode_map = {
                            n = 'NORMAL',
                            i = 'INSERT',
                            v = 'VISUAL',
                            V = 'V-LINE',
                            ['^V'] = 'V-BLOCK',
                            c = 'COMMAND',
                            R = 'REPLACE',
                            s = 'SELECT',
                            S = 'S-LINE',
                            ['^S'] = 'S-BLOCK',
                            t = 'TERMINAL',
                        }

                        return mode_map[mode] or mode:upper()
                    end
                },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
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
    end
}
