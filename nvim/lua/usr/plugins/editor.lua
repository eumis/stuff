return {
    {
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            event = "VeryLazy",
            branch = "main",
            config = function()
                require "nvim-treesitter.install".compilers = { "zig", "gcc", "clang" }
                -- require "nvim-treesitter".setup {
                --     -- ensure_installed = require("usr.treesitter"),
                --     sync_install = false,
                --     auto_install = false,
                --     modules = {},
                --     ignore_install = {},
                --     highlight = {
                --         enable = true,
                --         disable = {},
                --         additional_vim_regex_highlighting = false,
                --     }
                -- }
                require "nvim-treesitter".install(require "usr.parsers")
                vim.treesitter.language.register("markdown", "luamarkdown")
            end,
        }
    },
    {
        "folke/lazydev.nvim",
        event = "BufReadPre",
        ft = "lua",
        opts = {
            library = {}
        }
    },
    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help'
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                mapping = cmp.mapping.preset.insert(require('usr.keymap').get_cmp_mapping()),
                preselect = cmp.PreselectMode.None,
                sources = {
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'lazydev' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer' }
                }
            })
        end
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
        "catgoose/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup()
        end
    },
}
