--------------------------
-- Telescope
--------------------------
return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")

            local ivy_theme = themes.get_ivy()

            telescope.setup({
                defaults = {}
            })

            vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "Telescope: SpellSuggest" })
            vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Telescope: HelpTags" })

            vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: FindFiles" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: FindBuffers" })

            vim.keymap.set("n", "<leader>sg", builtin.grep_string, { desc = "Telescope: StringGrep" })
            vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope: LiveGrep" })
            vim.keymap.set("n", "<leader>bg", builtin.current_buffer_fuzzy_find, { desc = "Telescope: BufferGrep" })

            vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: GitStatus" })
            vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope: GitFiles" })
            vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope: GitBranches" })
            vim.keymap.set("n", "<leader>gt", builtin.git_stash, { desc = "Telescope: GitStash" })

            local config_opts = {
                layout_strategy = "vertical",
                layout_config = {
                    horizontal = {
                        prompt_position = "top"
                    }
                },
                search_dirs = { "~/.config/nvim" },
                prompt_prefix = "config -> ",
                prompt_title = "Search Config"
            }

            local grep_config = function() builtin.live_grep(config_opts) end
            local find_config = function() builtin.find_files(config_opts) end

            local notes_opts = {
                search_dirs = { "~/notes/vim" },
                prompt_prefix = "notes -> ",
                prompt_title = "Search Notes",
                prompt_position = "top"
            }
            local grep_notes = function() builtin.live_grep(notes_opts) end
            local find_notes = function() builtin.find_files(notes_opts) end

            vim.keymap.set("n", "<leader>gc", grep_config, {})
            vim.keymap.set("n", "<leader>fc", find_config, {})
            vim.keymap.set("n", "<leader>gn", grep_notes, {})
            vim.keymap.set("n", "<leader>fn", find_notes, {})
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
