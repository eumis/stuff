return {
    {
        'nvim-neotest/neotest',
        lazy = true,
        enabled = false,
        dependencies = {
            'nvim-neotest/neotest-python',
            'Issafalcon/neotest-dotnet'
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-python")({
                        dap = { justMyCode = false },
                        args = { "--log-level", "DEBUG" },
                        runner = "pytest",
                        python = "python",
                        is_test_file = function(file_path)
                            if vim.endswith(file_path, "_tests.py") then
                                return true
                            end
                            return false
                        end,
                    }),
                    require("neotest-dotnet")
                }
            })
        end
    },
}
