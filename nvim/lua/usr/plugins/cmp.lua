return {
    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            -- 'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help'
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                -- snippet = {
                --     expand = function(args)
                --         require('luasnip').lsp_expand(args.body)
                --     end,
                -- },
                mapping = cmp.mapping.preset.insert(require('usr.keymap').get_cmp_mapping()),
                sources = {
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'lazydev' },
                    { name = 'nvim_lsp' },
                    -- { name = 'luasnip' },
                    { name = 'path' },
                    { name = 'buffer' }
                }
            })
        end
    }
}
