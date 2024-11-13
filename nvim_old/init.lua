require('usr.plugins').setup_lazy()

require('usr.options').setup()
require('usr.treesitter').setup()
require('usr.cmp').setup()
--require('usr.copilot').setup()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "basedpyright",
        "omnisharp",
        "lemminx",
        "jsonls",
        "marksman",
        "html"
    }
})

require('mason-tool-installer').setup({
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
})

require('usr.lsp').setup()
require('usr.debug').setup()

require('usr.lang.lua').setup()
--require('usr.lang.python').setup_pyright()
require('usr.lang.python').setup_basedpyright()
require('usr.lang.csharp').setup_omnisharp()
require('usr.lang.json').setup_jsonls()
require('usr.lang.xml').setup_lemminx()
require('usr.lang.markdown').setup()
require('usr.lang.html').setup()
require('usr.lang.js').setup_ts_ls()

require('usr.testing').setup()

require('usr.git').setup()
-- require('files')
require('usr.editor').setup() --done
require('usr.style').setup() -- done
require('usr.statusline')
require('usr.telescope').setup()
require('nvim-tree').setup({ view = { width = 60, relativenumber = true } })
require('nvim-web-devicons').setup() -- done

require('usr.keymap').setup()

require('usr.luasnip').setup()

--[[require("neodev").setup({
    library = { plugins = { "nvim-dap-ui", "neotest" }, types = true }
})]]

pcall(require, "local")
