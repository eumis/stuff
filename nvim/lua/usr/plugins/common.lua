return {
    { 'nvim-lua/plenary.nvim', lazy = false },
    { 'nvim-neotest/nvim-nio', lazy = false },
    { "eumis/tasks.nvim",      branch = "dev", lazy = true },
    { "eumis/wdconfig.nvim",   branch = "dev", event = "VeryLazy", config = function() require("wdconfig").load_cwd() end }
}
