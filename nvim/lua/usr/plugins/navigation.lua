return {
    {
        'kyazdani42/nvim-tree.lua',
        lazy = false,
        opts = {
            view = {
                width = 60, relativenumber = true
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
                    fzf = {}
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
