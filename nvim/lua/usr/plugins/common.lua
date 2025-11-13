return {
    { "nvim-lua/plenary.nvim", lazy = false },
    {
        "eumis/tasks.nvim",
        branch = "dev",
        lazy = true,
        config = function() require("tasks").setup({ sort = "recent" }) end
    },
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
    {
        "eumis/runb.nvim",
        branch = "dev",
        lazy = true,
        config = function()
            vim.api.nvim_create_autocmd("User", {
                pattern = "RunbEnvChanged",
                callback = function(args)
                    require("usr.statusline").env.set_value(args.data.name)
                end
            })
        end
    },
}
