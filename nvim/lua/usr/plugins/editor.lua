return {
    {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            event = "VeryLazy",
            config = function()
                require "nvim-treesitter.install".compilers = { "zig", "gcc", "clang" }
                require "nvim-treesitter.configs".setup {
                    ensure_installed = require("usr.treesitter"),
                    sync_install = false,
                    auto_install = false,
                    modules = {},
                    ignore_install = {},
                    highlight = {
                        enable = true,
                        disable = {},
                        additional_vim_regex_highlighting = false,
                    }
                }
                vim.treesitter.language.register("markdown", "luamarkdown")
            end,
        }
    },
    {
        "windwp/nvim-autopairs",
        event = 'BufReadPre',
        config = function()
            require("nvim-autopairs").setup()
        end
    },
    {
        "numToStr/Comment.nvim",
        lazy = true,
        opts = {}
    },
    {
        "karb94/neoscroll.nvim",
        event = 'BufReadPre',
        config = function()
            require('neoscroll').setup({ mappings = { '<C-u>', '<C-d>' } })
        end
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup()
        end
    },
}
