return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")

            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                command = '/home/bmacdonald/.local/share/nvim/mason/bin/OpenDebugAD7',
            }

            dap.configurations.cpp = {
                {
                    name = "Launch Executable",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                },
                {
                    name = 'Attach to gdbserver :1234',
                    type = 'cppdbg',
                    request = 'launch',
                    MIMode = 'gdb',
                    miDebuggerServerAddress = 'localhost:1234',
                    miDebuggerPath = '/usr/bin/gdb',
                    cwd = '${workspaceFolder}',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                },
            }

            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            -- local dap_utils = require("dap.utils")
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

            vim.keymap.set('n', '<leader>df', function()
                dap_widgets.centered_float(dap_widgets.frames)
            end)

            vim.keymap.set('n', '<leader>ds', function()
                dap_widgets.centered_float(dap_widgets.scopes)
            end)
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
            vim.keymap.set("n", "<leader>df", dapui.float_element, { desc = "DapUI: Float Element" })
            vim.keymap.set("n", "<leader>dv", dapui.eval, { desc = "DapUI: Eval" })
        end
    },

    -------------------------------
    -- Language Specific Debuggers
    -------------------------------

    {
        "mfussenegger/nvim-dap-python",
        config = function()
            require("dap-python").setup("python3")
        end
    },
    {
        "leoluz/nvim-dap-go",
        config = function()
            -- Sets up nvim-dap configuration for Delve
            local dap_go = require("dap-go")
            dap_go.setup()

            vim.keymap.set("n", "<leader>dgt", dap_go.debug_test, { desc = "DapGo: DebugGoTest" })
            vim.keymap.set("n", "<leader>dgl", dap_go.debug_last_test, { desc = "DapGo: DebugGoLast" })
        end
    },
    {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = {
            "microsoft/vscode-js-debug", -- JS debugger to be installed through Mason
            build = "npm i && npm run compile vsDebugServerBundle && rm -rf out && mv dist out",
        },
        config = function()
            local dap = require("dap")
            local dap_node = require("dap-vscode-js")

            for _, language in ipairs({ "typescript", "javascript", "typescriptreact" }) do
                dap.configurations[language] = {
                    {
                        name = "Launch file",
                        type = "pwa-node",
                        request = "launch",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        name = "Attach to process",
                        port = 9229,
                        type = "pwa-node",
                        request = "attach",
                        processId = require('dap.utils').pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        name = "Auto Attach",
                        type = "pwa-node",
                        request = "attach",
                        cwd = vim.fn.getcwd()
                    },
                    {
                        name = "Start Chrome with \"localhost:3000\"",
                        type = "pwa-chrome",
                        url = "http://localhost:3000",
                        request = "launch",
                        webRoot = "${workspaceFolder}",
                        userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir"
                    }
                }
            end

            dap_node.setup({
                debugger_path = vim.fn.stdpath('data') .. "/lazy/vscode-js-debug",
                adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost', 'node', 'chrome' },
            })
        end
    }
}
