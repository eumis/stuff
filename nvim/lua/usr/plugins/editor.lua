return {
    {
        {
            'nvim-treesitter/nvim-treesitter',
            build = ":TSUpdate",
            event = 'VeryLazy',
            config = function()
                require 'nvim-treesitter.install'.compilers = { "zig", "gcc", "clang" }
                require 'nvim-treesitter.configs'.setup {
                    ensure_installed = require('usr.treesitter'),
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
            end,
        }
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        event = 'BufReadPre',
        main = "ibl",
        opts = {
            scope = {
                show_start = false,
                show_end = false
            }
        },
        init = function()
            vim.opt.list = true
        end
    },
    {
        'windwp/nvim-autopairs',
        event = 'BufReadPre',
        config = function()
            require('nvim-autopairs').setup()
        end
    },
    {
        'numToStr/Comment.nvim',
        event = 'BufReadPre'
    },
    {
        'karb94/neoscroll.nvim',
        event = 'BufReadPre',
        enabled = false,
        config = function()
            require('neoscroll').setup({ mappings = { '<C-u>', '<C-d>' } })
        end
    },
    {
        'Pocco81/auto-save.nvim',
        event = 'BufReadPre',
        opts = {
            enabled = true,
            write_all_buffers = false,
            on_off_commands = true,
            clean_command_line_interval = 0,
            debounce_delay = 500
        }
    },
    {
        'gregorias/coerce.nvim',
        event = 'BufReadPre',
        keys = { { 'cr' }, { 'gcr' } },
        config = function()
            require('coerce').setup({
                keymap_registry = require('coerce.keymap').keymap_registry(),
                -- The notification function used during error conditions.
                notify = function(...) return vim.notify(...) end,
                -- If you don’t like the default cases and modes, you can override them.
                cases = require('coerce').default_cases,
                modes = require('coerce').default_modes
            })
        end
    },
}
