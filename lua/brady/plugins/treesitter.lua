-- Tree sitter is a core Neovim feature: vim.treesitter
-- This plugin manages parser installation and ships query files for many languages.

local ensure_installed = { "lua", "c_sharp", "html", "css", "javascript", "json", "typescript", "tsx" }

local function preferred_parser_path(language)
    local parser_files = vim.api.nvim_get_runtime_file("parser/" .. language .. ".*", true)

    for _, parser_file in ipairs(parser_files) do
        if not parser_file:match("/lazy/nvim%-treesitter/parser/") then
            return parser_file
        end
    end

    return parser_files[1]
end

local function prefer_non_plugin_parsers()
    local parser_files = vim.api.nvim_get_runtime_file("parser/*.*", true)
    local preferred_paths = {}

    for _, parser_file in ipairs(parser_files) do
        local language = parser_file:match("/parser/([^/]+)%..+$")

        if language and not parser_file:match("/lazy/nvim%-treesitter/parser/") and not preferred_paths[language] then
            preferred_paths[language] = parser_file
        end
    end

    for language, parser_file in pairs(preferred_paths) do
        pcall(vim.treesitter.language.add, language, { path = parser_file })
    end
end

local function has_highlights_query(language)
    return #vim.api.nvim_get_runtime_file("queries/" .. language .. "/highlights.scm", true) > 0
end

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        init = function()
            local treesitter_runtime = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"

            vim.opt.runtimepath:append(treesitter_runtime)
            prefer_non_plugin_parsers()
        end,
        config = function()
            require("nvim-treesitter").setup()

            vim.treesitter.language.register("c_sharp", "cs")

            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TreesitterFeatures", {}),
                callback = function(event)
                    local filetype = vim.bo[event.buf].filetype
                    local language = vim.treesitter.language.get_lang(filetype) or filetype

                    -- Razor's treesitter highlights query is incomplete (mostly
                    -- white page). Use vim-razor's regex syntax instead.
                    if language == "razor" then
                        vim.bo[event.buf].syntax = "ON"
                        return
                    end

                    local parser_path = preferred_parser_path(language)
                    local has_parser = parser_path and vim.treesitter.language.add(language, { path = parser_path })
                        or vim.treesitter.language.add(language)

                    if not has_parser then
                        vim.bo[event.buf].syntax = "ON"
                        return
                    end

                    if not has_highlights_query(language) then
                        vim.bo[event.buf].syntax = "ON"
                        return
                    end

                    vim.treesitter.start(event.buf, language)
                    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                    if language == "c_sharp" then
                        vim.bo[event.buf].syntax = "ON"
                    end
                end,
            })

            vim.keymap.set({ "n", "x" }, "<C-space>", function()
                vim.treesitter.select("parent")
            end, { desc = "Treesitter: expand selection" })

            vim.keymap.set("x", "<bs>", function()
                vim.treesitter.select("child")
            end, { desc = "Treesitter: shrink selection" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local move = require("nvim-treesitter-textobjects.move")
            local select = require("nvim-treesitter-textobjects.select")

            require("nvim-treesitter-textobjects").setup({
                select = {
                    lookahead = true,
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "V",
                        ["@class.outer"] = "<c-v>",
                    },
                    include_surrounding_whitespace = true,
                },
                move = {
                    set_jumps = true,
                },
            })

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { desc = desc })
            end

            for _, mode in ipairs({ "x", "o" }) do
                map(mode, "af", function()
                    select.select_textobject("@function.outer")
                end, "Treesitter: select function")

                map(mode, "if", function()
                    select.select_textobject("@function.inner")
                end, "Treesitter: select inner function")

                map(mode, "ac", function()
                    select.select_textobject("@class.outer")
                end, "Treesitter: select class")

                map(mode, "ic", function()
                    select.select_textobject("@class.inner")
                end, "Treesitter: select inner class")

                map(mode, "as", function()
                    select.select_textobject("@local.scope", "locals")
                end, "Treesitter: select scope")
            end

            for _, mode in ipairs({ "n", "x", "o" }) do
                map(mode, "]m", function()
                    move.goto_next_start("@function.outer")
                end, "Treesitter: next function start")

                map(mode, "]]", function()
                    move.goto_next_start("@class.outer")
                end, "Treesitter: next class start")

                map(mode, "]M", function()
                    move.goto_next_end("@function.outer")
                end, "Treesitter: next function end")

                map(mode, "][", function()
                    move.goto_next_end("@class.outer")
                end, "Treesitter: next class end")

                map(mode, "[m", function()
                    move.goto_previous_start("@function.outer")
                end, "Treesitter: previous function start")

                map(mode, "[[", function()
                    move.goto_previous_start("@class.outer")
                end, "Treesitter: previous class start")

                map(mode, "[M", function()
                    move.goto_previous_end("@function.outer")
                end, "Treesitter: previous function end")

                map(mode, "[]", function()
                    move.goto_previous_end("@class.outer")
                end, "Treesitter: previous class end")
            end

            local function preview_location(method, not_found_message)
                local params = vim.lsp.util.make_position_params(0, "utf-8")

                vim.lsp.buf_request(0, method, params, function(error, result, context)
                    if error then
                        vim.notify(error.message, vim.log.levels.ERROR)
                        return
                    end

                    if not result or vim.tbl_isempty(result) then
                        vim.notify(not_found_message, vim.log.levels.INFO)
                        return
                    end

                    local location = vim.islist(result) and result[1] or result

                    if location.targetUri then
                        location = vim.lsp.util.location_link_to_location(location, context.client_id)
                    end

                    vim.lsp.util.preview_location(location, { border = "none" })
                end)
            end

            map("n", "<leader>fd", function()
                preview_location("textDocument/definition", "No definition found")
            end, "LSP: preview definition")

            map("n", "<leader>Fd", function()
                preview_location("textDocument/typeDefinition", "No type definition found")
            end, "LSP: preview type definition")
        end,
    },
}
