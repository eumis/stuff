local M = {}

local setup_lsp = function()
    local lsp = require('usr.lsp')
    local lspconfig = require('lspconfig')
    local util = require('lspconfig.util')
    local pid = vim.fn.getpid()

    lspconfig.omnisharp.setup({
        on_attach = function(client, bufnr)
            client.server_capabilities.semanticTokensProvider = nil
            lsp.on_attach(client, bufnr)
        end,
        capabilities = lsp.capabilities,
        handlers = {
            ["textDocument/definition"] = require('omnisharp_extended').handler,
        },
        cmd = { 'omnisharp', "--languageserver", "--hostPID", tostring(pid) },
        flags = {
            debounce_text_changes = 150,
        },
        root_dir = function(fname)
            local root_patterns = { '*.sln', 'omnisharp.json', '.git' }
            return util.root_pattern(root_patterns)(fname)
        end,
        enable_roslyn_analyzers = true,
        analyze_open_documents_only = true,
        enable_import_completion = true,
        enable_editorconfig_support = true
    })
end

local setup_debug = function()
    local dap = require('dap')
    dap.adapters.coreclr = {
        type = 'executable',
        command = 'netcoredbg',
        args = { '--interpreter=vscode' }
    }
    dap.configurations.cs = {
        {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            program = function()
                return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
            end,
        },
    }
    local mason_registry = require("mason-registry")
    local codelldb = mason_registry.get_package("netcoredbg") -- note that this will error if you provide a non-existent package name
    local install_dir = codelldb:get_install_path()
    dap.adapters.netcoredbg = {
        type = 'executable',
        command = install_dir .. '/packages/netcoredbg/netcoredbg',
        args = { '--interpreter=vscode' }
    }
end

local setup_tests = function()
    local adapter = require("neotest-dotnet")({
        dap = { justMyCode = false },
        dotnet_additional_args = {
            "--verbosity detailed"
        },
        discovery_root = "project"
    })
    require('usr.testing').add_neotest_adapter(adapter)
end

function M.setup_omnisharp()
    setup_lsp()
    setup_debug()
    -- setup_tests()
end

return M
