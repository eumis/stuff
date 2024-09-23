local M = {}

function M.setup_lazy()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
      vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
      })
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
        --Copilot
        --Plug 'https://github.com/github/copilot.vim'
        --Plug 'zbirenbaum/copilot.lua'
        --Plug 'zbirenbaum/copilot-cmp'

        --Common
        'nvim-lua/plenary.nvim',
        'nvim-neotest/nvim-nio',

        --git
        'tpope/vim-fugitive',
        'lewis6991/gitsigns.nvim',

        --search
        'nvim-telescope/telescope.nvim',
        'nvim-telescope/telescope-fzy-native.nvim',
        'ThePrimeagen/harpoon',

        --treesitter
        {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"},

        --editor
        'numToStr/Comment.nvim',
        'lukas-reineke/indent-blankline.nvim',
        'gregorias/coerce.nvim',
        --Plug 'windwp/nvim-ts-autotag'

        --files
        'kyazdani42/nvim-tree.lua',
        'Pocco81/auto-save.nvim',

        --lsp
        'folke/neodev.nvim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig',
        'ray-x/lsp_signature.nvim',
        'Hoffs/omnisharp-extended-lsp.nvim',
        'gbrlsnchs/telescope-lsp-handlers.nvim',
        'nvim-lua/lsp-status.nvim',
        --Plug 'onsails/lspkind-nvim'

        --debug
        'mfussenegger/nvim-dap',
        'mfussenegger/nvim-dap-python',
        'rcarriga/nvim-dap-ui',

        --tests
        'antoinemadec/FixCursorHold.nvim',
        'nvim-neotest/neotest',
        'nvim-neotest/neotest-python',
        'Issafalcon/neotest-dotnet',
        --
        --snippets
        'L3MON4D3/LuaSnip',

        --autocomplete
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'windwp/nvim-autopairs',

        --Plug 'puremourning/vimspector'

        --visual
        'mhinz/vim-startify',
        'nvim-lualine/lualine.nvim',
        --Plug 'feline-nvim/feline.nvim', { 'branch': 'develop' }

        --themes
        'rktjmp/lush.nvim',
        'xiyaowong/nvim-transparent',
        'Mofiqul/vscode.nvim',
        'ellisonleao/gruvbox.nvim',

        'p00f/nvim-ts-rainbow',
        'kyazdani42/nvim-web-devicons',
        'norcalli/nvim-colorizer.lua',
        'karb94/neoscroll.nvim',
        'nvim-lua/popup.nvim',

        --org mode
        --Plug 'nvim-neorg/neorg'
        --Plug 'nvim-orgmode/orgmode'
    })
end

function M.setup()
    local Plug = vim.fn['plug#']

    vim.call('plug#begin', '~/.nvim/plugged')

    --Copilot
    --Plug 'https://github.com/github/copilot.vim'
    --Plug 'zbirenbaum/copilot.lua'
    --Plug 'zbirenbaum/copilot-cmp'

    --Common
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-neotest/nvim-nio'

    --git
    Plug 'tpope/vim-fugitive'
    Plug 'lewis6991/gitsigns.nvim'

    --search
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzy-native.nvim'
    Plug 'ThePrimeagen/harpoon'

    --treesitter
    Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })

    --editor
    Plug 'numToStr/Comment.nvim'
    Plug 'lukas-reineke/indent-blankline.nvim'
    Plug 'gregorias/coerce.nvim'
    --Plug 'windwp/nvim-ts-autotag'

    --files
    Plug 'kyazdani42/nvim-tree.lua'
    Plug 'Pocco81/auto-save.nvim'

    --lsp
    Plug 'folke/neodev.nvim'
    Plug 'williamboman/mason.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'neovim/nvim-lspconfig'
    Plug 'ray-x/lsp_signature.nvim'
    Plug 'Hoffs/omnisharp-extended-lsp.nvim'
    Plug 'gbrlsnchs/telescope-lsp-handlers.nvim'
    Plug 'nvim-lua/lsp-status.nvim'
    --Plug 'onsails/lspkind-nvim'

    --debug
    Plug 'mfussenegger/nvim-dap'
    Plug 'mfussenegger/nvim-dap-python'
    Plug 'rcarriga/nvim-dap-ui'

    --tests
    Plug 'antoinemadec/FixCursorHold.nvim'
    Plug 'nvim-neotest/neotest'
    Plug 'nvim-neotest/neotest-python'
    Plug 'Issafalcon/neotest-dotnet'

    --autocomplete
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'windwp/nvim-autopairs'

    --snippets
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'L3MON4D3/LuaSnip'
    --Plug 'puremourning/vimspector'

    --visual
    Plug 'mhinz/vim-startify'
    Plug 'nvim-lualine/lualine.nvim'
    --Plug 'feline-nvim/feline.nvim', { 'branch': 'develop' }

    --themes
    Plug 'rktjmp/lush.nvim'
    Plug 'xiyaowong/nvim-transparent'
    Plug 'Mofiqul/vscode.nvim'
    Plug 'ellisonleao/gruvbox.nvim'

    Plug 'p00f/nvim-ts-rainbow'
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'norcalli/nvim-colorizer.lua'
    Plug 'karb94/neoscroll.nvim'
    Plug 'nvim-lua/popup.nvim'

    --org mode
    --Plug 'nvim-neorg/neorg'
    --Plug 'nvim-orgmode/orgmode'

    vim.call('plug#end')
end

return M
