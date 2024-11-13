local M = {}
local keymap = require('usr.keymap')
local capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

function M.on_attach(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    keymap.setup_lsp_keys(bufnr)
end

function M.setup()
    vim.diagnostic.config({
        virtual_text = {
            severity = {
                min = vim.diagnostic.severity.WARN
            }
        },
        update_in_insert = true
    })

    require('lsp_signature').setup()
    require('lsp-status').status()
    require('lsp-status').register_progress()
end

return M
