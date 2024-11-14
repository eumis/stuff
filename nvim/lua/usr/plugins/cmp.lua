return {
    {
        'hrsh7th/nvim-cmp',
        lazy = false,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
        },
        config = function()
            require('cmp').setup({
                --snippet = { expand = function() end },
                mapping = require('usr.keymap').get_cmp_mapping(),
                sources = {
                    { name = 'lazydev' },
                    { name = 'luasnip' },
                    { name = 'nvim_lsp' },
                    { name = 'path' }
                }
            })
        end
    },
}
