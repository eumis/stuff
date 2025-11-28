return {
    {
        "sindrets/diffview.nvim",
        lazy = true,
        config = function()
            require("diffview").setup({
                keymaps = require("usr.keymap").get_diffview_keymaps(),
                file_panel = {
                    win_config = {
                        position = "left",
                        width = 70,
                        win_opts = {},
                    },
                },
            })
        end
    },
    {
        "FabijanZulj/blame.nvim",
        event = "VeryLazy",
        config = function()
            require('blame').setup()
        end,
    },
}
