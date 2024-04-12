--------------------------
-- DAP Config
--------------------------
return {
    {
        -- Nvim DAP Client
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            vim.keymap.set("n", "<leader>c", dap.continue)
            vim.keymap.set("n", "<leader>so", dap.step_over)
            vim.keymap.set("n", "<leader>si", dap.step_into)
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint)
            vim.keymap.set("n", "<leader>B", function()
                -- Conditional breakpoint
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
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
            local dapui = require("dapui")

            dapui.setup({
                force_buffers = true,
                layouts = {
                    {
                        elements = {
                            {
                                id = "scopes",
                                size = 0.25, -- Can be float or integer > 1
                            },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                        },
                        size = 40,
                        position = "left", -- Can be "left" or "right"
                    },
                },
                floating = {
                    max_height = nil,
                    max_width = nil,
                    border = "single",
                    mappings = {
                        ["close"] = { "q", "<Esc>" },
                    },
                },
            })

            vim.keymap.set("n", "<leader>do", dapui.open, { desc = "DapUI: Debugger Open" })
            vim.keymap.set("n", "<leader>dc", dapui.close, { desc = "DapUI: Debugger Close" })
            vim.keymap.set("n", "<leader>dt", dapui.toggle, { desc = "DapUI: Debugger Toggle" })
            vim.keymap.set("n", "<leader>df", dapui.float_element, { desc = "DapUI: Float Element" })

            vim.keymap.set("n", "<leader>dv", dapui.eval)
        end
    },

    --------------------------
    -- Language Specific Debuggers
    -----------------------------

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
        -- JS debug adapter
        "mxsdev/nvim-dap-vscode-js",
        dependencies = {
            -- The JS debugger
            "microsoft/vscode-js-debug", -- Installed through Mason
            build = "npm i && npm run compile vsDebugServerBundle && mv dist out",
        },
        config = function()
            local dap_node = require("dap-vscode-js")

            dap_node.setup({
                debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug",
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
            })
        end
    }
}
