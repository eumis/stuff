local M = {}

function M.setup_eslint()
    local lsp = require 'usr.lsp'
    require('lspconfig').eslint.setup({
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach
    })
end

function M.setup_biome()
    local lsp = require 'usr.lsp'
    local util = require 'lspconfig.util'
    require('lspconfig').biome.setup({
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach,
        root_dir = util.root_pattern('biome.json', 'biome.jsonc', '.git'),
        single_file_support = true
    })
end

function M.setup_ts_ls()
    local lsp = require 'usr.lsp'
    require('lspconfig').ts_ls.setup({
        capabilities = lsp.capabilities,
        on_attach = lsp.on_attach
    })
end

return M
