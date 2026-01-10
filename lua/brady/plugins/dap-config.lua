return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        config = function()
            local dap = require("dap")
            local dap_widgets = require("dap.ui.widgets")

            vim.keymap.set("n", "<leader>cc", dap.continue, { desc = "Dap: Continue" })
            vim.keymap.set("n", "<leader>cx", dap.run_to_cursor, { desc = "Dap: RunToCursor" })
            vim.keymap.set("n", "<leader>so", dap.step_over, { desc = "Dap: StepOver" })
            vim.keymap.set("n", "<leader>si", dap.step_into, { desc = "Dap: StepInto" })
            vim.keymap.set("n", "<leader>su", dap.step_out, { desc = "Dap: StepOut" })
            vim.keymap.set("n", "<leader>cb", dap.clear_breakpoints, { desc = "Dap: ClearBreakpoints" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Dap: ToggleBreakpoint" })
            vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Dap: Quit" })
            vim.keymap.set("n", "<leader>dr", function()
                dap.repl.toggle()
                vim.api.nvim_input("<C-w>ji") -- move to repl window
            end, { desc = "Dap: ToggleRepl" })

            vim.keymap.set("n", "<leader>B", function()
                dap.toggle_breakpoint(vim.fn.input("Breakpoint Condition: "))
            end, { desc = "Dap: ConditionalBreakpoint" })

            vim.keymap.set('n', '<leader>ds', function()
                dap_widgets.centered_float(dap_widgets.scopes)
            end)
        end
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        event = "UIEnter",
        config = function()
            local dapui = require("dapui")
            ---@diagnostic disable-next-line: missing-fields
            dapui.setup({
                force_buffers = true,
                layouts = {
                    {
                        elements = {
                            { id = "stacks",  size = 0.25 },
                            { id = "scopes",  size = 0.25 },
                            { id = "watches", size = 0.50 },
                        },
                        size = 40,
                        position = "left",
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
            vim.keymap.set("n", "<leader>dg", dapui.float_element, { desc = "DapUI: Float Element" })
            vim.keymap.set("n", "<leader>dv", dapui.eval, { desc = "DapUI: Eval" })
        end
    },

    -------------------------------
    -- Language Specific Debuggers
    -------------------------------

    {
        "mfussenegger/nvim-dap-python", -- python-debugpy
        event = "VeryLazy",
        config = function()
            require("dap-python").setup("python3")
        end
    },
    {
        "leoluz/nvim-dap-go", -- delve
        event = "VeryLazy",
        config = function()
            local dap_go = require("dap-go")
            dap_go.setup()

            vim.keymap.set("n", "<leader>dgt", dap_go.debug_test, { desc = "DapGo: DebugGoTest" })
            vim.keymap.set("n", "<leader>dgl", dap_go.debug_last_test, { desc = "DapGo: DebugGoLast" })
        end
    },
    {
        "mxsdev/nvim-dap-vscode-js",
        event = "VeryLazy",
        config = function()
            local dap = require("dap")
            local dap_node = require("dap-vscode-js")

            for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
                local pwaType = "pwa-" .. adapterType

                if not dap.adapters[pwaType] then
                    dap.adapters[pwaType] = {
                        type = "server",
                        host = "localhost",
                        port = "${port}",
                        executable = {
                            command = "js-debug-adapter",
                            args = { "${port}" },
                        },
                    }
                end
            end

            local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

            local vscode = require("dap.ext.vscode")
            vscode.type_to_filetypes["node"] = js_filetypes
            vscode.type_to_filetypes["pwa-node"] = js_filetypes

            for _, language in ipairs(js_filetypes) do
                if not dap.configurations[language] then
                    local runtimeExecutable = nil
                    if language:find("typescript") then
                        runtimeExecutable = vim.fn.executable("tsx") == 1 and "tsx" or "ts-node"
                    end
                    dap.configurations[language] = {
                        {
                            type = "pwa-node",
                            request = "launch",
                            name = "Launch file",
                            program = "${file}",
                            cwd = "${workspaceFolder}",
                            sourceMaps = true,
                            runtimeExecutable = runtimeExecutable,
                            skipFiles = {
                                "<node_internals>/**",
                                "node_modules/**",
                            },
                            resolveSourceMapLocations = {
                                "${workspaceFolder}/**",
                                "!**/node_modules/**",
                            },
                        },
                        {
                            type = "pwa-node",
                            request = "attach",
                            name = "Attach",
                            processId = require("dap.utils").pick_process,
                            cwd = "${workspaceFolder}",
                            sourceMaps = true,
                            runtimeExecutable = runtimeExecutable,
                            skipFiles = {
                                "<node_internals>/**",
                                "node_modules/**",
                            },
                            resolveSourceMapLocations = {
                                "${workspaceFolder}/**",
                                "!**/node_modules/**",
                            },
                        },
                    }
                end
            end

            -- for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
            --     dap.configurations[language] = {
            --         {
            --             name = "Launch file",
            --             type = "pwa-node",
            --             request = "launch",
            --             program = "${file}",
            --             port = "${port}",
            --             cwd = "${workspaceFolder}",
            --         },
            --         {
            --             name = "Attach to process",
            --             port = "${port}",
            --             type = "pwa-node",
            --             request = "attach",
            --             processId = require('dap.utils').pick_process,
            --             cwd = "${workspaceFolder}",
            --         },
            --         {
            --             name = "Auto Attach",
            --             type = "pwa-node",
            --             port = "${port}",
            --             request = "attach",
            --             cwd = vim.fn.getcwd()
            --         },
            --         {
            --             name = "Start Chrome with \"localhost:3000\"",
            --             type = "pwa-chrome",
            --             url = "http://localhost:3000",
            --             port = "${port}",
            --             request = "launch",
            --             webRoot = "${workspaceFolder}",
            --             userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
            --         }
            --     }
            -- end

            dap_node.setup({
                debugger_path = "/home/bmacdonald/source/vscode-js-debug",
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
            })
        end
    }
}
