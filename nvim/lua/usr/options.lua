local M = {}

function M.setup()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.expandtab = true
    vim.opt.smartindent = true
    vim.opt.wrap = false
    vim.opt.smartcase = true
    vim.opt.incsearch = true
    vim.opt.nu = true
    vim.opt.relativenumber = true
    vim.opt.scrolloff = 10
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

    vim.cmd('filetype plugin indent on')
    vim.cmd('syntax')
    vim.opt.completeopt = 'menu,menuone,noselect'

    --let python_highlight_all=1
end

return M
