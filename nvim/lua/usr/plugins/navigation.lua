return {
    {
        'nvim-tree/nvim-tree.lua',
        lazy = false,
        opts = {
            view = {
                relativenumber = true,
                float = {
                    enable = true,
                    quit_on_focus_loss = true,
                    open_win_config = function()
                        local win_id = vim.api.nvim_get_current_win()
                        local row, col = unpack(vim.api.nvim_win_get_position(win_id))
                        local screen_w = vim.api.nvim_win_get_width(win_id)
                        local screen_h = vim.api.nvim_win_get_height(win_id)
                        local tree_width = 70
                        local center_x = col + (screen_w - tree_width) / 2
                        local center_y = row + 5
                        return {
                            border = "rounded",
                            relative = "editor",
                            row = center_y,
                            col = center_x,
                            width = tree_width,
                            height = screen_h - 10
                        }
                    end
                }
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                    window_picker = {
                        enable = false,
                        picker = "default"
                    }
                }
            },
            on_attach = function(bufnr)
                local api = require "nvim-tree.api"
                api.config.mappings.default_on_attach(bufnr)
                vim.keymap.set("n", '<C-t><C-t>', function() require('usr.terminal').float_terminal() end)
            end
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
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                        -- the default case_mode is "smart_case"
                    }
                }
            }
            require('telescope').load_extension('fzf')
        end
    },
    {
        "ThePrimeagen/harpoon",
        -- lazy = true,
        -- branch = "harpoon2",
        -- enabled = false,
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("harpoon").setup {
                menu = {
                    width = vim.api.nvim_win_get_width(0) - 20,
                }
            }
        end
        -- config = function()
        --     local harpoon = require("harpoon")
        --     harpoon:setup({
        --         settings = {
        --             save_on_toggle = true,
        --             sync_on_ui_close = true
        --         }
        --     })
        --     vim.keymap.set("n", "<C-g><C-a>", function() harpoon:list():add() end)
        --     vim.keymap.set("n", "<C-g><C-g>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
        -- end
    }
}
