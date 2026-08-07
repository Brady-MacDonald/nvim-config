return {
    "nickjvandyke/opencode.nvim",
    version = "*", -- Latest stable release
    config = function()
        local opencode = require("opencode")

        vim.keymap.set({ "n", "x" }, "<C-x>s", opencode.select, { desc = "Opencode: Select" })

        vim.keymap.set({ "n", "x" }, "<C-x>a", opencode.ask, { desc = "Opencode: Ask" })
        vim.keymap.set({ "n", "x" }, "<C-x>t", function() opencode.ask("@this: ") end, { desc = "Opencode: Ask @this" })

        vim.keymap.set({ "n" }, "goo", function() return opencode.operator("@this ") .. "_" end,
            { desc = "Append line to OpenCode", expr = true })

        vim.keymap.set({ "n" }, "<S-C-u>", function() opencode.command("session.half.page.up") end)
        vim.keymap.set({ "n" }, "<S-C-d>", function() opencode.command("session.half.page.down") end)
    end,
}
