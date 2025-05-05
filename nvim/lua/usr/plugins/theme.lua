return {
    {
        'Mofiqul/vscode.nvim',
        lazy = false,
        priority = 1000,
        config = function()
            vim.o.background = 'dark'
            local c = require('vscode.colors')
            require('vscode').setup({
                transparent = false,
                italic_comments = false,
                disable_nvimtree_bg = true,
                color_overrides = {
                    vscBack = '#282C34',
                    vscPopupBack = '#282C34'
                },
                group_overrides = {
                    Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
                }
            })
            require('vscode').load()
        end
    },
    -- {
    --     'xiyaowong/nvim-transparent',
    --     lazy = false,
    --     priority = 999,
    --     opts = {
    --         extra_groups = {
    --             "BufferLineTabClose",
    --             "BufferlineBufferSelected",
    --             "BufferLineFill",
    --             "BufferLineBackground",
    --             "BufferLineSeparator",
    --             "BufferLineIndicatorSelected",
    --             "NvimTreeRootFolder",
    --             "NvimTreeEmptyFoldername",
    --             "NvimTreeTreeFolderName",
    --             "NvimTreeNormal",
    --             "NvimTreeNormalFloat",
    --             "NvimTreeNormalPopup",
    --             "NvimTreeWindowPicker",
    --             "NvimTreeEndOfBuffer",
    --             "NvimTreeOpenedFolderName",
    --             "NvimTreeVertSplit",
    --             "VertSplit"
    --         },
    --         exclude_groups = {},
    --     }
    -- },
    { 'norcalli/nvim-colorizer.lua', event = "VeryLazy", lazy = true, config = function() require('colorizer').setup() end },
    {
        'kyazdani42/nvim-web-devicons',
        lazy = false,
        opts = {
            override = {
                luamarkdown = {
                    icon = '󰽛',
                    name = 'luamarkdown'
                }
            },
            override_by_extension = {
                ['luamd'] = {
                    icon = '󰽛',
                    name = 'luamarkdown'
                }
            }
        }
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        config = function()
            require('dashboard').setup {
                theme = 'hyper',
                config = {
                    week_header = { enable = true },
                    project = { enable = false },
                    mru = { enable = true, limit = 10, cwd_only = true }
                }
            }
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        opts = {
            options = {
                theme = 'vscode'
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { { 'filename', file_status = true, path = 1 }, function() return require('auto.environment')
                    .current().__name__ end },
                lualine_x = { "require'lsp-status'.status()", 'encoding', 'fileformat', 'filetype' },
                lualine_y = { 'progress' },
                lualine_z = { 'location', "vim.api.nvim_buf_line_count(0)" }
            }
        }
    }
}
