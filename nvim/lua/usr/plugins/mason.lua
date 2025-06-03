return {
    {
        'williamboman/mason.nvim',
        lazy = true,
        cmd = 'Mason',
        opts = {}
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        cond = false,
        dependencies = {
            'williamboman/mason.nvim'
        },
        opts = {
            ensure_installed = {
                'lua_ls',
                'basedpyright',
                'omnisharp',
                'lemminx',
                'jsonls',
                'marksman',
                'html',
                'netcoredbg'
            }
        }
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        lazy = false,
        dependencies = {
            'williamboman/mason.nvim'
        },
        opts = {
            ensure_installed = {
                -- lsp
                'lua-language-server',
                'basedpyright',
                'omnisharp',
                -- {'omnisharp', version = 'v1.39.11'},
                'lemminx',
                'json-lsp',
                'marksman',
                'html-lsp',
                'bash-language-server',
                'typescript-language-server',

                -- tools
                'prettier',
                'yapf',
                'isort'
            },
            integrations = {
                ['mason-lspconfig'] = false,
                ['mason-null-ls'] = false,
                ['mason-nvim-dap'] = false,
            }
        }
    }
}
