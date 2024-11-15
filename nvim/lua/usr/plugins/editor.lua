return {
    {
        {
            'nvim-treesitter/nvim-treesitter',
            build = ":TSUpdate",
            event = 'VeryLazy',
            config = function()
                require 'nvim-treesitter.install'.compilers = { "zig", "gcc", "clang" }
                require 'nvim-treesitter.configs'.setup {
                    -- One of "all", "maintained" (parsers with maintainers), or a list of languages
                    ensure_installed = require('usr.treesitter'),

                    -- Install languages synchronously (only applied to `ensure_installed`)
                    sync_install = false,

                    auto_install = false,

                    -- List of parsers to ignore installing
                    ignore_install = {},

                    highlight = {
                        -- `false` will disable the whole extension
                        enable = true,

                        -- list of language that will be disabled
                        disable = {},

                        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                        -- Using this option may slow down your editor, and you may see some duplicate highlights.
                        -- Instead of true it can also be a list of languages
                        additional_vim_regex_highlighting = false,
                    },
                    rainbow = {
                        enable = true,
                        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
                        max_file_lines = nil, -- Do not enable for files with more than n lines, int
                        -- colors = {}, -- table of hex strings
                        -- termcolors = {} -- table of colour name strings
                    }
                }
                local original_ft_to_lang = require('nvim-treesitter.parsers').ft_to_lang
                require('nvim-treesitter.parsers').ft_to_lang = function(ft)
                    if ft == 'zsh' then
                        return 'bash'
                    end
                    return original_ft_to_lang(ft)
                end
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
    { 'windwp/nvim-autopairs', event = 'BufReadPre' },
    { 'numToStr/Comment.nvim', event = 'BufReadPre' },
    {
        'karb94/neoscroll.nvim',
        event = 'BufReadPre',
        config = function()
            require('neoscroll').setup({ mappings = {'<C-u>', '<C-d>'} })
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
