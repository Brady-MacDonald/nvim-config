local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local snippet = luasnip.snippet
local s = luasnip.s

local tNode = luasnip.text_node
local iNode = luasnip.insert_node
local fNode = luasnip.function_node

-- local cNode = luasnip.choice_node
--
-- luasnip.add_snippets("typescript", {
--     snippet("choice", { cNode(1, tNode("Hello"), tNode("World"))})
-- })


-- Use TS to get surrounding function and log all parameters
local param_log = function()
    local TS = require("brady.treesitter.function_start")

    local func_node, paramters = TS.get_func_node(vim.bo.filetype)
    if func_node == nil then
        vim.notify("Unable to perform ParameterLog", "error")
        return
    end

    local clg = ""
    for idx, param in ipairs(paramters) do
        clg = clg .. "console.log(" .. param .. "); "
    end

    return clg
end

local langs = { "typescript", "javascript", "typescriptreact", "javascriptscriptreact", "vue" }

for _, lang in ipairs(langs) do
    -- Console Log
    luasnip.add_snippets(lang, {
        snippet("clg", {
            tNode('console.log('),
            iNode(1),
            tNode(')')
        })
    })

    -- String Log
    luasnip.add_snippets(lang, {
        snippet("slg", {
            tNode('console.log("'),
            iNode(1, "Here"),
            tNode('")')
        })
    })

    -- Wrapped Log
    luasnip.add_snippets(lang, {
        s("wlg",
            fmt("console.log('----------------');\nconsole.log({});\nconsole.log('----------------');\n",
                { iNode(1) }
            ))
    })

    -- Parameter Log
    luasnip.add_snippets(lang, {
        snippet("plg",
            fmt('console.log("----------------");\n{}\nconsole.log("----------------");\n{}',
                { fNode(param_log), iNode(1) }
            ))
    })
end
