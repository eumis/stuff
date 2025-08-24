return {
    {
        "sindrets/diffview.nvim",
        lazy = true,
        event = "VeryLazy",
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
        "NeogitOrg/neogit",
        lazy = true,
        dependencies = {
            "nvim-lua/plenary.nvim",
            -- "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim"
        },
        opts = {
            mappings = {
                status = {
                    ["="] = "Toggle"
                }
            }
        }
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "BufReadPre",
        opts = {}
    }
}
