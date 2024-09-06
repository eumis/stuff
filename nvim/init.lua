require('usr.plugins').setup_lazy()

require('usr.options').setup()
require('usr.treesitter').setup()
require('usr.cmp').setup()
--require('usr.copilot').setup()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls", "basedpyright", "omnisharp", "lemminx", "jsonls" }
})

require('usr.lsp').setup()
require('usr.debug').setup()

require('usr.lang.lua').setup()
--require('usr.lang.python').setup_pyright()
require('usr.lang.python').setup_basedpyright()
require('usr.lang.csharp').setup_omnisharp()
require('usr.lang.json').setup_jsonls()
require('usr.lang.xml').setup_lemminx()

require('usr.testing').setup()

require('usr.git').setup()
-- require('files')
require('usr.editor').setup()
require('usr.style').setup()
require('usr.statusline')
require('usr.telescope').setup()
require('nvim-tree').setup({ view = { width = 60, relativenumber = true } })
require('nvim-web-devicons').setup()

require('usr.keymap').setup()

--[[require("neodev").setup({
    library = { plugins = { "nvim-dap-ui", "neotest" }, types = true }
})]]

pcall(require, "local")
