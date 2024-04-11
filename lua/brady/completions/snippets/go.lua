-------------
-- Go snipptes
--------------
local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt

local snippet = luasnip.snippet
local s = luasnip.s

local tNode = luasnip.text_node
local iNode = luasnip.insert_node

luasnip.add_snippets("go", {
	snippet("pl", {
		tNode("fmt.Println("),
		iNode(1),
		tNode(")")
	})
})

luasnip.add_snippets("go", {
	s("wpl",
		fmt('fmt.Println("----------------");\nfmt.Println({});\nfmt.Println("----------------");\n',
			{ iNode(1) }
		))
})

-- luasnip.add_snippets("go", {
--     s("enn",
--         fmt('if err != nil {\nreturn err\n}',
--             { iNode(1) }
--         ))
-- })
