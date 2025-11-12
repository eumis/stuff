return {
    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help'
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                mapping = cmp.mapping.preset.insert(require('usr.keymap').get_cmp_mapping()),
                sources = {
                    { name = 'nvim_lsp_signature_help' },
                    { name = 'lazydev' },
                    { name = 'nvim_lsp' },
                    { name = 'path' },
                    { name = 'buffer' }
                }
            })
        end
    }
}
