return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local builtin = require("telescope.builtin")

        local colors = require("tokyonight.colors").setup()
        local accent = colors.blue
        local bg = colors.bg
        local border = colors.bg_highlight

        --- Little highlight function helper
        ---@param group string name of the highlight group
        ---@param opts vim.api.keyset.highlight options for the highlight group
        local hl = function(group, opts)
            vim.api.nvim_set_hl(0, group, opts)
        end

        hl("TelescopePromptTitle", { fg = bg, bg = accent })
        hl("TelescopeResultsTitle", { fg = bg, bg = accent })
        hl("TelescopePreviewTitle", { fg = bg, bg = accent })
        hl("TelescopePromptPrefix", { fg = accent })
        hl("TelescopePromptNormal", { bg = bg })
        hl("TelescopePromptBorder", { bg = bg, fg = border })
        hl("TelescopeResultsNormal", { bg = bg })
        hl("TelescopeResultsBorder", { bg = bg, fg = border })
        hl("TelescopePreviewNormal", { bg = bg })
        hl("TelescopePreviewBorder", { bg = bg, fg = border })
        hl("TelescopeNormal", { bg = bg })

        require('telescope').setup {
            defaults = {
                sorting_strategy = "ascending",
                file_ignore_patterns = { "node_modules", "pkg" },
                selection_caret = "  ",
                borderchars = {
                    prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                    results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                    preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                },
            },
            pickers = {
                find_files = {
                    layout_strategy = "flex",
                    prompt_prefix = "  ",
                    prompt_title = "Find Files",
                    sorting_strategy = "ascending",
                    layout_config = {
                        flex = { flip_columns = 100 },
                        horizontal = {
                            prompt_position = 'top',
                            width = 0.8,
                            height = 0.9,
                            preview_cutoff = 10,
                            preview_width = 0.5,
                        },
                        vertical = {
                            prompt_position = 'top',
                            width = 0.8,
                            height = 0.9,
                            preview_cutoff = 10,
                            preview_height = 0.5,
                        },
                    },
                },
                buffers = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Buffers",
                },
                registers = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Registers",
                },
                help_tags = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Help Tags",
                },
                keymaps = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Keymaps",
                },
                builtin = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Telescope Builtin",
                },
                marks = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Marks",
                },
                git_status = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Git Status",
                },
                git_files = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Git Files",
                },
                git_branches = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Git Branches",
                },
                git_stash = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Git Stash",
                },
                git_bcommits = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Git Buffer Commits",
                },
                git_commits = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Git Commits",
                },
                lsp_document_symbols = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Document Symbols",
                },
                lsp_workspace_symbols = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Workspace Symbols",
                },
                lsp_dynamic_workspace_symbols = {
                    theme = "dropdown",
                    prompt_prefix = "  ",
                    prompt_title = "Workspace Symbols",
                },

                -- ivy: bottom pane, fast to scan
                live_grep = {
                    theme = "ivy",
                    prompt_prefix = "  ",
                    prompt_title = "Live Grep",
                },
                grep_string = {
                    theme = "ivy",
                    prompt_prefix = "  ",
                    prompt_title = "Grep String",
                },
                current_buffer_fuzzy_find = {
                    theme = "ivy",
                    prompt_prefix = "  ",
                    prompt_title = "Buffer Lines",
                },
                diagnostics = {
                    theme = "ivy",
                    prompt_prefix = "  ",
                    prompt_title = "Diagnostics",
                },
                lsp_references = {
                    theme = "ivy",
                    prompt_prefix = "  ",
                    prompt_title = "References",
                },
                lsp_definitions = {
                    theme = "ivy",
                    prompt_prefix = "  ",
                    prompt_title = "Definitions",
                },
                lsp_implementations = {
                    theme = "ivy",
                    prompt_prefix = "  ",
                    prompt_title = "Implementations",
                },
                lsp_type_definitions = {
                    theme = "ivy",
                    prompt_prefix = "  ",
                    prompt_title = "Type Definitions",
                },

                -- cursor: anchored near the cursor
                spell_suggest = {
                    theme = "cursor",
                    prompt_prefix = "  ",
                    prompt_title = "Spelling",
                },
            },
        }

        vim.keymap.set({ "n", "v" }, "<leader>tr", builtin.registers, { desc = "Telescope: Registers" })
        vim.keymap.set("n", "z=", builtin.spell_suggest, { desc = "Telescope: SpellSuggest" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope: FindBuffers" })
        vim.keymap.set("n", "<leader>ht", builtin.help_tags, { desc = "Telescope: HelpTags" })
        vim.keymap.set("n", "<leader>tk", builtin.keymaps, { desc = "Telescope: Keymaps" })
        vim.keymap.set("n", "<leader>tb", builtin.builtin, { desc = "Telescope: Builtin" })
        vim.keymap.set("n", "<leader>tm", builtin.marks, { desc = "Telescope: Marks" })
        vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Telescope: GitStatus" })
        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Telescope: GitFiles" })
        vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Telescope: GitBranches" })
        vim.keymap.set("n", "<leader>gt", builtin.git_stash, { desc = "Telescope: GitStash" })
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope: FindFiles" })
        vim.keymap.set("n", "<leader>lg", builtin.live_grep, { desc = "Telescope: LiveGrep" })
        vim.keymap.set("n", "<leader>sg", builtin.grep_string, { desc = "Telescope: StringGrep" })
        vim.keymap.set("n", "<leader>bg", builtin.current_buffer_fuzzy_find, { desc = "Telescope: BufferGrep" })
        vim.keymap.set("n", "<leader>gbc", builtin.git_bcommits, { desc = "Telescope: GitBufferCommits" })
        vim.keymap.set("n", "<leader>gcc", builtin.git_commits, { desc = "Telescope: GitCommits" })
    end
}
