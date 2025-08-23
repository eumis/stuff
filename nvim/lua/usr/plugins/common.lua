return {
    { 'nvim-lua/plenary.nvim', lazy = false },
    { 'nvim-neotest/nvim-nio', lazy = false },
    { "eumis/tasks.nvim",      branch = "dev", lazy = true },
    {
        "eumis/wdconfig.nvim",
        branch = "dev",
        event = "VeryLazy",
        config = function()
            local Path = require "plenary.path"
            local home = vim.fn.expand('~')
            local user_config = Path:new(home, 'data', 'user.lua')
            require("wdconfig").load(user_config)
            require("wdconfig").load_cwd()
        end
    },
    { "eumis/runb.nvim", branch = "dev", lazy = true },
}
