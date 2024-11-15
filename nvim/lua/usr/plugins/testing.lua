return {
    {
        'nvim-neotest/neotest',
        lazy = true,
        dependencies = {
            { 'nvim-neotest/neotest-python', lazy = true },
            { 'Issafalcon/neotest-dotnet',   lazy = true },
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
