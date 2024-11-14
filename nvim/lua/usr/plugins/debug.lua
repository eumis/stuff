return {
    {
        'mfussenegger/nvim-dap',
        lazy = true,
        dependencies = {
            'mfussenegger/nvim-dap-python',
            'rcarriga/nvim-dap-ui'
        },
        config = function()
            local dap  = require("dap")

            require('dap-python').setup('python')
            require('dap-python').test_runner = 'pytest'

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
