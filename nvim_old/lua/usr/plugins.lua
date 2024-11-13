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
        'nvim-lua/plenary.nvim', --done
        'nvim-neotest/nvim-nio', --done

        --git
        'tpope/vim-fugitive', --done
        'lewis6991/gitsigns.nvim', --done

        --search
        'nvim-telescope/telescope.nvim', --done
        'nvim-telescope/telescope-fzy-native.nvim', --done
        'ThePrimeagen/harpoon', --done

        --treesitter
        {'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"}, --done

        --editor
        'numToStr/Comment.nvim', --done
        'lukas-reineke/indent-blankline.nvim', --done
        'gregorias/coerce.nvim', --done
        --Plug 'windwp/nvim-ts-autotag'

        --files
        'kyazdani42/nvim-tree.lua', --done
        'Pocco81/auto-save.nvim', --done

        --lsp
        'neovim/nvim-lspconfig',
        'folke/neodev.nvim', --notsure shouldbe lazydev
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
        'hrsh7th/nvim-cmp', --done
        'hrsh7th/cmp-nvim-lsp', --done
        'hrsh7th/cmp-buffer', --done
        'hrsh7th/cmp-path', --done
        'hrsh7th/cmp-cmdline', --done
        'saadparwaiz1/cmp_luasnip', --done
        'windwp/nvim-autopairs', --done

        --Plug 'puremourning/vimspector'

        --visual
        'mhinz/vim-startify', --done
        'nvim-lualine/lualine.nvim', --done
        --Plug 'feline-nvim/feline.nvim', { 'branch': 'develop' }

        --themes
        'rktjmp/lush.nvim',
        'xiyaowong/nvim-transparent', -- done
        'Mofiqul/vscode.nvim', -- done
        'ellisonleao/gruvbox.nvim', --notsure

        'kyazdani42/nvim-web-devicons', -- done
        'norcalli/nvim-colorizer.lua', -- done
        'karb94/neoscroll.nvim', --done
        'nvim-lua/popup.nvim', --notsure

        --org mode
        --Plug 'nvim-neorg/neorg'
        --Plug 'nvim-orgmode/orgmode'
    })
end

return M
