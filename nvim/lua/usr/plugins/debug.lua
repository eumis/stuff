return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        dependencies = {
            { 'mfussenegger/nvim-dap-python', lazy = true },
            { 'rcarriga/nvim-dap-ui',         lazy = true }
        },
        config = function()
            local dap = require("dap")

            require('dap-python').setup('python')
            require('dap-python').test_runner = 'pytest'

            dap.adapters.coreclr = {
                type = 'executable',
                command = 'netcoredbg',
                args = { '--interpreter=vscode' }
            }

            -- table.insert(require("dap").configurations.cs, {
            --     type = "coreclr",
            --     name = "debug some service",
            --     request = "launch",
            --     program = function()
            --         return "bin/Debug/net8.0/service.dll"
            --     end,
            --     cwd = "cwd",
            --     args = { "--urls", "http://localhost:4000" },
            --     env = {
            --         ["DOTNET_ENVIRONMENT"] = "Development",
            --     },
            -- })

            local dapui = require('dapui')
            dapui.setup()
            ---@diagnostic disable-next-line: undefined-field
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            ---@diagnostic disable-next-line: undefined-field
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            ---@diagnostic disable-next-line: undefined-field
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            ---@diagnostic disable-next-line: undefined-field
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end
    },
}
