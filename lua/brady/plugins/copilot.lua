return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = {
        "copilotlsp-nvim/copilot-lsp",  -- for NES functionality
    },
    config = function()
        require("copilot").setup({
            -- auth_provider_url = "https://github.com/NetManagement",
            -- suggestion = { enabled = false },
            -- panel = { enabled = false },
        })
    end,
}
