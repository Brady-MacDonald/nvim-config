--------------------------
-- Telescope
--------------------------
return {
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")

            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = {
                        "node_modules"
                    }
                }
            }

            --- Change the highlight for Telescope to the given theme
            ---@param name string
            local function set_telescope_highlights(name)
                local colors = require("brady.themes").get_theme(name)
                local telescope_hl = require("brady.themes.highlights.telescope").get_highlight_groups(colors)
                for hl, val in pairs(telescope_hl) do
                    vim.api.nvim_set_hl(0, hl, val)
                end
            end

            vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "Telescope: SpellSuggest" })
            vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Telescope: HelpTags" })
            vim.keymap.set("n", "<leader>tk", builtin.keymaps, { desc = "Telescope: Keymaps" })
            vim.keymap.set("n", "<leader>tb", builtin.builtin, { desc = "Telescope: Builtin" })

            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: FindBuffers" })
            vim.keymap.set("n", "<leader>ff", function()
                set_telescope_highlights("dracula")
                builtin.find_files({
                    prompt_prefix = "   ",
                    selection_caret = " ",
                    entry_prefix = " ",
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                        },
                        width = 0.87,
                        height = 0.80,
                    },
                    mappings = {
                        n = { ["q"] = require("telescope.actions").close },
                    },
                })
            end, { desc = "Telescope: FindFiles" })

            vim.keymap.set("n", "<leader>sg", function()
                set_telescope_highlights("rosepine")
                builtin.grep_string(themes.get_ivy({
                    prompt_prefix = "  ",
                    prompt_title = "String Grep"
                }))
            end, { desc = "Telescope: StringGrep" })

            vim.keymap.set("n", "<leader>lg", function()
                set_telescope_highlights("rosepine")
                builtin.live_grep(themes.get_ivy({
                    prompt_prefix = "  ",
                    prompt_title = "Live Grep"
                }))
            end, { desc = "Telescope: LiveGrep" })

            vim.keymap.set("n", "<leader>bg", function()
                set_telescope_highlights("rosepine")
                builtin.current_buffer_fuzzy_find(themes.get_ivy({
                    prompt_prefix = "  ",
                    prompt_title = "Buffer Grep"
                }))
            end, { desc = "Telescope: BufferGrep" })

            vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: GitStatus" })
            vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope: GitFiles" })
            vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope: GitBranches" })
            vim.keymap.set("n", "<leader>gt", builtin.git_stash, { desc = "Telescope: GitStash" })
            vim.keymap.set("n", "<leader>gbc", builtin.git_bcommits, { desc = "Telescope: GitBufferCommits" })
            vim.keymap.set("n", "<leader>gcc", builtin.git_bcommits, { desc = "Telescope: GitCommits" })

            local config_opts = {
                search_dirs = { "~/.config/nvim" },
                prompt_prefix = "config   ",
                prompt_title = "Search Config"
            }

            local grep_config = function() builtin.live_grep(themes.get_ivy(config_opts)) end
            local find_config = function() builtin.find_files(themes.get_ivy(config_opts)) end

            local notes_opts = {
                search_dirs = { "~/notes/nvim" },
                prompt_prefix = "notes   ",
                prompt_title = "Search Notes",
                prompt_position = "top",
                layout_config = {
                    width = 100,
                    height = 20,
                },
            }

            local grep_notes = function() builtin.live_grep(notes_opts) end
            local find_notes = function() builtin.find_files(themes.get_cursor(notes_opts)) end

            vim.keymap.set("n", "<leader>gc", grep_config, { desc = "Telescope: GrepConfig" })
            vim.keymap.set("n", "<leader>fc", find_config, { desc = "Telescope: FindConfig" })
            vim.keymap.set("n", "<leader>gn", grep_notes, { desc = "Telescope: GrepNotes" })
            vim.keymap.set("n", "<leader>fn", find_notes, { desc = "Telescope: FindNotes" })
        end
    },

    -- Code Actions Telescope UI
    {
        "nvim-telescope/telescope-ui-select.nvim",
        config = function()
            local telescope = require("telescope")
            local themes = require("telescope.themes")

            telescope.setup({
                extensions = {
                    ["ui-select"] = {
                        themes.get_dropdown()
                    }
                }
            })

            telescope.load_extension("ui-select")
        end
    }
}
