local ls = require "luasnip"

local s, i, t, c, f = ls.s, ls.insert_node, ls.text_node, ls.choice_node, ls.function_node
local fmt = require("luasnip.extras.fmt").fmt

-- This a choice snippet. You can move through with <c-l> (in my config)
c(1, { t { "hello" }, t { "world" }, })

ls.snippets = {
    -- Available in any filetype
    all = {
        ls.parser.parse_snippet("expand", "-- This is expanded for all filetypes")
    },
    lua = {
        -- local builtin = require "telescope.pickers.builtin"
        -- local telescope.builtin.whatever = require "telescope.builtin.whatever"
        -- local telescope.builtin = require "telescope.builtin"
        s(
            "requ",
            fmt([[local {} = require "{}"]], {
                f(function(import_name)
                    local parts = vim.split(import_name[1][1], ".", true)
                    return parts[#parts] or ""
                end, { 1 }),
                i(1),
            })
        ),
    }
}
