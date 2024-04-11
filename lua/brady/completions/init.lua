-- Bring in all completion related code

-- nvim-cmp: Completion Engine which we can provide a custom source
-- nvim-cmp will take completions from multiple sources
-- then format them into a single dropdown to select from
require("brady.completions.completions")

-- lua-snip: Create Custom snippets
-- The snippets are just one possible completion source offered to nvim-cmp
require("brady.completions.snippets")
