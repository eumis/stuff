local M = {}

local setup_debug = function()
    require('dap-python').setup('python')
    require('dap-python').test_runner = 'pytest'
end

local setup_tests = function()
    local adapter = require("neotest-python")({
        dap = { justMyCode = false },
        args = { "--log-level", "DEBUG" },
        runner = "pytest",
        python = "python",
        is_test_file = function(file_path)
            if vim.endswith(file_path, "_tests.py") then
                return true
            end
            return false
        end,
    })
    require('usr.testing').add_neotest_adapter(adapter)
end

local setup_pyright = function()
    local lsp = require('usr.lsp')
    local lspconfig = require('lspconfig')

    local on_attach = function(_, bufnr)
        -- _ variable is client
        lsp.on_attach(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local file_name = vim.api.nvim_buf_get_name(bufnr)
        file_name = vim.fn.fnamemodify(file_name, ':p')
        vim.keymap.set('n', '<space>e', ':!yapf '..file_name..' -i && isort '..file_name..'<CR>', opts)
        vim.keymap.set('n', '<space>ud', function() require("dap-python").test_method() end, opts)
    end

    lspconfig.pyright.setup({
        on_attach = on_attach,
        capabilities = lsp.capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic",
                    enableTypeIgnoreComments = true,
                    diagnosticSeverityOverrides = {
                        -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
                        strictParameterNoneValue = false,
                        autoImportCompletions = true,
                        reportOptionalSubscript = "warning",
                        reportOptionalMemberAccess = "warning",
                        reportOptionalIterable = "warning",
                        reportGeneralTypeIssues = "warning"
                    }
                }
            }
        }
    })
end

function M.setup_pyright()
    setup_pyright()
    setup_debug()
    setup_tests()
end

local setup_basedpyright = function()
    local lsp = require('usr.lsp')
    local lspconfig = require('lspconfig')

    local on_attach = function(_, bufnr)
        -- _ variable is client
        lsp.on_attach(_, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', '<space>e', "<cmd>silent !yapf '%' -i && isort '%'<CR>", opts)
        vim.keymap.set('n', '<space>ud', function() require("dap-python").test_method() end, opts)
    end

    lspconfig.basedpyright.setup({
        on_attach = on_attach,
        capabilities = lsp.capabilities,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            basedpyright = {
                analysis = {
                    autoSearchPaths = true,
                    --diagnosticMode = 'workspace',
                    enableTypeIgnoreComments = true,
                    typeCheckingMode = 'standard', -- standard, strict, all, off, basic
                    diagnosticSeverityOverrides = {
                        strictParameterNoneValue = false,
                        autoImportCompletions = true,
                        reportOptionalSubscript = "warning",
                        reportOptionalMemberAccess = "warning",
                        reportOptionalIterable = "warning",
                        reportGeneralTypeIssues = "warning"
                    }
                },
            }
        }
    })
end

function M.setup_basedpyright()
    setup_basedpyright()
    setup_debug()
    setup_tests()
end

local setup_pylsp = function()
    local lsp = require('usr.lsp')
    local lspconfig = require('lspconfig')

    lspconfig.pylsp.setup({
        on_attach = lsp.on_attach,
        capabilities = lsp.capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    })
end

function M.setup_pylsp()
    setup_pylsp()
    setup_debug()
    setup_tests()
end

return M
