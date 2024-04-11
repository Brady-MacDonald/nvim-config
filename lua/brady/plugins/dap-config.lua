--------------------------
-- DAP Config
--------------------------

return {
    {
        -- NeoVIM DAP Client
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            vim.keymap.set("n", "<leader>c", dap.continue)
            vim.keymap.set("n", "<leader>so", dap.step_over)
            vim.keymap.set("n", "<leader>si", dap.step_into)
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>B", function()
                -- Toggle condigional break point
                dap.toggle_breakpoint(vim.fn.input("Breakpoint Condition: "))
            end)

            for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
                require("dap").configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        name = "Attach to process",
                        type = "pwa-node",
                        request = "attach",
                        processId = require('dap.utils').pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-chrome",
                        request = "launch",
                        name = "Start Chrome with \"localhost\"",
                        url = "http://localhost:3000",
                        webRoot = "${workspaceFolder}",
                        userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
                    }
                }
            end
        end
    },
    {
        -- UI for debugger
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
            local dapui = require("dapui")

            dapui.setup()

            vim.keymap.set("n", "<leader>do", dapui.open)
            vim.keymap.set("n", "<leader>dc", dapui.close)
            vim.keymap.set("n", "<leader>dt", dapui.toggle)

            vim.keymap.set("n", "<leader>dv", dapui.eval)
        end
    },

    -- Language Specific Debug Adapters

    -- Go Delve debugger installed with Mason
    {
        "leoluz/nvim-dap-go",
        config = function()
            require("dap-go").setup()

            -- local dap_go = require("dap-go")
            -- dap_go.debug_test()
        end
    },

    -- javascript/typescript
    {
        -- The JS debug adapter
        "mxsdev/nvim-dap-vscode-js",
        -- The JS debugger
        dependencies = {
            "microsoft/vscode-js-debug", -- Installed through Mason?
            build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
        },
        config = function()
            local dap_node = require("dap-vscode-js")

            dap_node.setup({
                -- debugger_cmd = { "/home/bmacdonald/.local/share/nvim/mason/packages/js-debug-adapter/js-debug-adapter" },
                debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug",
                -- node_path = "node",
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
            })
        end
    }
}
