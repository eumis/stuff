return {
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = function() require('mason').setup() end
    },
    {
        'williamboman/mason-lspconfig.nvim',
        lazy = false,
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim'
        },
        opts = {
            ensure_installed = {
                "lua_ls",
                "basedpyright",
                "omnisharp",
                "lemminx",
                "jsonls",
                "marksman",
                "html"
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