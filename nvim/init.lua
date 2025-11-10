-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 15
vim.opt.guicursor =
'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
vim.opt.encoding = 'UTF-8'
vim.opt.hidden = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.shortmess:append('c')
vim.opt.autoread = true
vim.opt.clipboard:append('unnamedplus')
vim.opt.termguicolors = true
vim.opt.guifont = 'CodeNewRoman\\ NF:h9'

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.showmatch = true

vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand('~/.local/state/nvim/undodir')

vim.filetype.add {
    extension = {
        zsh = "sh",
        sh = "sh", -- force sh-files with zsh-shebang to still get sh as filetype
        luamd = "markdown"
    },
    filename = {
        [".zshrc"] = "sh",
        [".zshenv"] = "sh"
    },
}

vim.cmd('filetype plugin indent on')
vim.cmd('syntax')
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.langmap =
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'
vim.g.mapspace = ' '

require('usr.keymap')

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        require('usr.statusline')
        require("usr.luamd")
    end
})

vim.cmd.colorscheme("lunaperche")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

local augroup = vim.api.nvim_create_augroup("UserConfig", {})
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.highlight.on_yank()
    end
})

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "usr/plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = false },
    change_detection = { enabled = false }
})
