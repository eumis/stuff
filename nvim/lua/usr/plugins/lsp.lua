return {
    {
        "folke/lazydev.nvim",
        event = 'BufReadPre',
        ft = "lua",
        dependencies = {
            --'justinsgithub/wezterm-types',
        },
        opts = {
            library = {
                --{ path = "wezterm-types", mods = { "wezterm" } },
            }
        }
    },
    {
        'gbrlsnchs/telescope-lsp-handlers.nvim',
        lazy = true,
        config = function()
            require('telescope').load_extension('lsp_handlers')
        end
    },
    {
        'neovim/nvim-lspconfig',
        event = 'BufReadPre',
        dependencies = {
            'hrsh7th/nvim-cmp',
            'ray-x/lsp_signature.nvim',
            'Hoffs/omnisharp-extended-lsp.nvim',
            'gbrlsnchs/telescope-lsp-handlers.nvim',
            'nvim-lua/lsp-status.nvim',
            'j-hui/fidget.nvim',
        },
        config = function()
            vim.diagnostic.config({
                virtual_text = {
                    severity = {
                        min = vim.diagnostic.severity.WARN
                    }
                },
                update_in_insert = true
            })

            require('lsp_signature').setup()

            local servers = {
                html = {},
                ts_ls = {},
                marksman = {
                    {
                        filetypes = { 'markdown', 'luamarkdown' }
                    },
                    remap = function(bufnr)
                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        vim.keymap.set('n', '<space>e', ":silent !prettier '%' --write<CR>", opts)
                    end
                },
                bashls = {},
                omnisharp = { {
                    on_init = function(client, _)
                        if client.server_capabilities then
                            client.server_capabilities.semanticTokensProvider = false -- turn off semantic tokens
                        end
                    end,
                    handlers = {
                        ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
                        ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
                        ["textDocument/references"] = require('omnisharp_extended').references_handler,
                        ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
                    },
                    cmd = { 'OmniSharp', "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
                    flags = {
                        debounce_text_changes = 150,
                    },
                    root_dir = function(fname)
                        local root_patterns = { '*.sln', 'omnisharp.json', '.git' }
                        return require('lspconfig.util').root_pattern(root_patterns)(fname)
                    end,
                    settings = {
                        FormattingOptions = {
                            -- Enables support for reading code style, naming convention and analyzer
                            -- settings from .editorconfig.
                            EnableEditorConfigSupport = true,
                            -- Specifies whether 'using' directives should be grouped and sorted during
                            -- document formatting.
                            OrganizeImports = nil,
                        },
                        MsBuild = {
                            -- If true, MSBuild project system will only load projects for files that
                            -- were opened in the editor. This setting is useful for big C# codebases
                            -- and allows for faster initialization of code navigation features only
                            -- for projects that are relevant to code that is being edited. With this
                            -- setting enabled OmniSharp may load fewer projects and may thus display
                            -- incomplete reference lists for symbols.
                            LoadProjectsOnDemand = nil,
                        },
                        RoslynExtensionsOptions = {
                            -- Enables support for roslyn analyzers, code fixes and rulesets.
                            EnableAnalyzersSupport = true,
                            EnableDecompilationSupport = true,
                            -- Enables support for showing unimported types and unimported extension
                            -- methods in completion lists. When committed, the appropriate using
                            -- directive will be added at the top of the current file. This option can
                            -- have a negative impact on initial completion responsiveness,
                            -- particularly for the first few completion sessions after opening a
                            -- solution.
                            EnableImportCompletion = nil,
                            -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
                            -- true
                            AnalyzeOpenDocumentsOnly = nil,
                        },
                        Sdk = {
                            -- Specifies whether to include preview versions of the .NET SDK when
                            -- determining which version to use for project loading.
                            IncludePrereleases = true,
                        },
                    },
                } },
                jsonls = {
                    {},
                    -- remap = function(bufnr)
                    --     local opts = { noremap = true, silent = true, buffer = bufnr }
                    --     vim.keymap.set('n', '<space>e', ":silent !prettier '%' --write<CR>", opts)
                    -- end
                },
                lua_ls = {},
                basedpyright = {
                    {
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
                    },
                    remap = function(bufnr)
                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        -- vim.keymap.set('n', '<space>e', "<cmd>silent !yapf % -i && isort %<CR>", opts)
                        vim.keymap.set('n', '<space>e', "<cmd>silent !black % && isort %<CR>", opts)
                        -- vim.keymap.set('n', '<space>e', "<cmd>silent !autopep8 -i --agressive --experimental % && isort %<CR>", opts)
                    end
                },
                pyright = {
                    disabled = true,
                    {
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
                    },
                    remap = function(bufnr)
                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        vim.keymap.set('n', '<space>e', "<cmd>silent !yapf '%' -i && isort '%'<CR>", opts)
                    end
                },
                lemminx = { {
                    filetypes = { 'xml', 'xsd', 'xsl', 'xslt', 'svg' },
                    settings = {
                        xml = {
                            completion = { autoCloseTags = true },
                            validation = { noGrammar = "hint" }
                        }
                    }
                } },
                kotlin_language_server = {}
            }

            local lspconfig = require('lspconfig')
            local cmp_lsp = require("cmp_nvim_lsp")
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                cmp_lsp.default_capabilities()
            )
            capabilities.textDocument.completion.completionItem.snippetSupport = true
            for name, config in pairs(servers) do
                if config.disabled == nil or not config.disabled then
                    config = config[1]
                    if config == nil then
                        config = {}
                    end
                    config = vim.tbl_deep_extend("force", {}, {
                        capabilities = capabilities,
                    }, config)

                    lspconfig[name].setup(config)
                end
            end

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    local server_config = servers[client.name]
                    if server_config == nil then return end
                    if server_config.semanticTokensProvider ~= nil then
                        client.server_capabilities.semanticTokensProvider = server_config.semanticTokensProvider
                    end
                    vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = args.buf })
                    require('usr.keymap').setup_lsp_keys(args.buf)
                    if server_config.remap ~= nil then
                        server_config.remap(args.buf)
                    end
                end,
            })

            --require('fidget').setup({})
            local lsp_status = require('lsp-status')
            lsp_status.status()
            lsp_status.register_progress()
        end
    }
}
