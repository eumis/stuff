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
        lazy = true,
        opts = {}
    },
    {
        'karb94/neoscroll.nvim',
        event = 'BufReadPre',
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
        opts = {
            default_mode_keymap_prefixes = require('usr.keymap').get_coerce_prefices(),
        },
    },
    {
        "OXY2DEV/markview.nvim",
        ft = "markdown",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        config = function()
            local markview = require('markview')
            markview.keymaps.createKeymap = function(buffer)
                vim.api.nvim_buf_set_keymap(buffer, "n", "gx", "", {
                    desc = "gx patch for Markview.nvim",
                    callback = function ()
                        local keymaps = require('markview.keymaps')
                        local buf_links = keymaps.views[buffer] or {};
                        local cursor = vim.api.nvim_win_get_cursor(0);

                        local address = vim.fn.expand('<cfile>')
                        for _, link in ipairs(buf_links) do
                            if link.row_start + 1 == cursor[1] and cursor[2] >= link.col_start and cursor[2] <= link.col_end then
                                address = link.address
                                break
                            end
                        end

                        require('usr.url').open_url(address)
                    end

                })
            end
            markview.setup({
                headings = {
                    heading_1 = {
                        style = 'icon',
                        shift_char = '',
                        icon = ' '
                    },
                    heading_2 = {
                        style = 'icon',
                        shift_char = '',
                        icon = ' '
                    },
                    heading_3 = {
                        style = 'icon',
                        shift_char = '',
                        icon = ' '
                    },
                    heading_4 = {
                        style = 'icon',
                        shift_char = '',
                        icon = ' '
                    },
                    heading_5 = {
                        style = 'icon',
                        shift_char = '',
                        icon = ' '
                    },
                    heading_6 = {
                        style = 'icon',
                        shift_char = '',
                        icon = ' '
                    },
                    heading_7 = {
                        style = 'icon',
                        shift_char = '',
                        icon = ' '
                    },
                    heading_8 = {
                        style = 'icon',
                        shift_char = '',
                        icon = ' '
                    },
                }
            })
        end
    }
}
