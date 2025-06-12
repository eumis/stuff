return {
    {
        'tpope/vim-fugitive',
        cmd = {'G', 'Git'},
        enabled = false
    },
    {
        'sindrets/diffview.nvim',
        lazy = true,
        config = function()
            require('diffview').setup({
                keymaps = require('usr.keymap').get_diffview_keymaps()
            })
        end
    },
    {
        'NeogitOrg/neogit',
        lazy = true,
        enabled = true,
        dependencies = {
            'nvim-lua/plenary.nvim',
            -- 'sindrets/diffview.nvim',
            "nvim-telescope/telescope.nvim"
        },
        opts = {
            mappings = {
                status = {
                    ['='] = 'Toggle'
                }
            }
        }
    },
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufReadPre',
        opts = {}
    }
}
