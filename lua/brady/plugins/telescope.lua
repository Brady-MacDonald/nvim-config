return {
    {
        'nvim-telescope/telescope.nvim',
        event = "VeryLazy",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")

            local ivy = themes.get_ivy()
            -- local cursor = themes.get_cursor()
            -- local drops = themes.get_dropdown()

            require('telescope').setup {
                defaults = {
                    file_ignore_patterns = { "node_modules", "pkg" }
                }
            }

            local h_pct = 0.90
            local w_pct = 0.80
            local w_limit = 75

            local spell_setup = {
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                preview = { hide_on_startup = true },
                layout_strategy = 'vertical',
                sorting_strategy = "ascending",
                prompt_prefix = "search   ",
                prompt_title = "Spelling",
                layout_config = {
                    vertical = {
                        mirror = true,
                        prompt_position = 'top',
                        width = function(_, cols, _)
                            return math.min(math.floor(w_pct * cols), w_limit)
                        end,
                        height = function(_, _, rows)
                            return math.floor(rows * h_pct)
                        end,
                        preview_cutoff = 10,
                        preview_height = 0.4,
                    },
                },
            }
            local ff_setup = {
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                preview = { hide_on_startup = false },
                layout_strategy = 'flex',
                sorting_strategy = "ascending",
                prompt_prefix = "file   ",
                prompt_title = "Find Files",
                layout_config = {
                    flex = { flip_columns = 100 },
                    horizontal = {
                        mirror = false,
                        prompt_position = 'top',
                        width = function(_, cols, _)
                            return math.floor(cols * w_pct)
                        end,
                        height = function(_, _, rows)
                            return math.floor(rows * h_pct)
                        end,
                        preview_cutoff = 10,
                        preview_width = 0.5,
                    },
                    vertical = {
                        mirror = true,
                        prompt_position = 'top',
                        width = function(_, cols, _)
                            return math.floor(cols * w_pct)
                        end,
                        height = function(_, _, rows)
                            return math.floor(rows * h_pct)
                        end,
                        preview_cutoff = 10,
                        preview_height = 0.5,
                    },
                },
            }

            vim.keymap.set({ "n", "v" }, "<leader>tr", builtin.registers, { desc = "Telescope: Registers" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: FindBuffers" })
            vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Telescope: HelpTags" })
            vim.keymap.set("n", "<leader>tk", builtin.keymaps, { desc = "Telescope: Keymaps" })
            vim.keymap.set("n", "<leader>tb", builtin.builtin, { desc = "Telescope: Builtin" })
            vim.keymap.set("n", "<leader>tm", builtin.marks, { desc = "Telescope: Marks" })
            vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: GitStatus" })
            vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope: GitFiles" })
            vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope: GitBranches" })
            vim.keymap.set("n", "<leader>gt", builtin.git_stash, { desc = "Telescope: GitStash" })
            vim.keymap.set("n", "<leader>gbc", builtin.git_bcommits, { desc = "Telescope: GitBufferCommits" })
            vim.keymap.set("n", "<leader>gcc", builtin.git_bcommits, { desc = "Telescope: GitCommits" })
            vim.keymap.set("n", "z=", function() builtin.spell_suggest(spell_setup) end,
                { desc = "Telescope: SpellSuggest" })

            vim.keymap.set("n", "<leader>ff", function() builtin.find_files(ff_setup) end,
                { desc = "Telescope: FindFiles" })

            vim.keymap.set("n", "<leader>lg", function() builtin.live_grep(ivy) end, { desc = "Telescope: LiveGrep" })
            vim.keymap.set("n", "<leader>sg", function() builtin.grep_string(ivy) end,
                { desc = "Telescope: StringGrep" })
            vim.keymap.set("n", "<leader>bg", function() builtin.current_buffer_fuzzy_find(ivy) end,
                { desc = "Telescope: BufferGrep" })
        end
    },
    {
        "nvim-telescope/telescope-ui-select.nvim",
        event = "UIEnter",
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
