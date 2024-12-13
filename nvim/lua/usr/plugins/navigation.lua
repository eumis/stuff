return {
    {
        'kyazdani42/nvim-tree.lua',
        lazy = false,
        opts = {
            view = {
                width = 60, relativenumber = true
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                    window_picker = {
                        enable = false,
                        picker = "default"
                    }
                }
            }
        }
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        lazy = true,
        config = function()
            require('telescope').setup {
                defaults = {
                    results_title = false,
                    sorting_strategy = "ascending",
                    layout_strategy = "center",
                    layout_config = {
                        preview_cutoff = 1, -- Preview should always show (unless previewer = false)
                        anchor = "N",
                        width = 0.8,
                        height = 0.3,
                    },
                    border = true,
                    borderchars = {
                        prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                        results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                    },
                    path_display = function(_, path)
                        local tail = require("telescope.utils").path_tail(path)
                        return string.format("%s (%s)", tail, path)
                    end,

                    mappings = {
                        i = {
                            ['<esc>'] = require('telescope.actions').close,
                            ['<C-c>'] = require('telescope.actions').delete_buffer
                        }
                    }
                },
                pickers = {
                },
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }
            require('telescope').load_extension('fzf')
        end
    },
    {
        "ThePrimeagen/harpoon",
        lazy = true,
        opts = {
            menu = {
                width = vim.api.nvim_win_get_width(0) - 20
            }
        }
    }
}
