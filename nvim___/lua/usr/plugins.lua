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
        'numToStr/Comment.nvim', --done
        'lukas-reineke/indent-blankline.nvim',
        'gregorias/coerce.nvim',
        --Plug 'windwp/nvim-ts-autotag'

        --files
        'kyazdani42/nvim-tree.lua',
        'Pocco81/auto-save.nvim', --done

        --lsp
        'neovim/nvim-lspconfig',
        'folke/neodev.nvim',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
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
        --"rafamadriz/friendly-snippets",

        --autocomplete
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip',
        'windwp/nvim-autopairs', --done

        --Plug 'puremourning/vimspector'

        --visual
        'mhinz/vim-startify',
        'nvim-lualine/lualine.nvim',
        --Plug 'feline-nvim/feline.nvim', { 'branch': 'develop' }

        --themes
        'rktjmp/lush.nvim',
        'xiyaowong/nvim-transparent', -- done
        'Mofiqul/vscode.nvim', -- done
        'ellisonleao/gruvbox.nvim',

        'kyazdani42/nvim-web-devicons', -- done
        'norcalli/nvim-colorizer.lua', -- done
        'karb94/neoscroll.nvim', --done
        'nvim-lua/popup.nvim',

        --org mode
        --Plug 'nvim-neorg/neorg'
        --Plug 'nvim-orgmode/orgmode'
    })
end

return M
