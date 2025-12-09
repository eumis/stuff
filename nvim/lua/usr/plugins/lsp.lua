return {
    {
        "folke/lazydev.nvim",
        event = "BufReadPre",
        ft = "lua",
        opts = {
            library = {}
        }
    },
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "hrsh7th/nvim-cmp",
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

            local servers = {
                "html",
                "ts_ls",
                "marksman",
                "bashls",
                "omnisharp",
                "jsonls",
                "lua_ls",
                "basedpyright",
                "lemminx",
                "html",
                "rust_analyzer"
                -- "roslyn_ls"
            }

            vim.lsp.config("*", {
                flags = {
                    debounce_text_changes = 100,
                },
            })

            vim.lsp.config("basedpyright", {
                settings = {
                    basedpyright = {
                        analysis = {
                            autoSearchPaths = true,
                            --diagnosticMode = "workspace",
                            enableTypeIgnoreComments = true,
                            typeCheckingMode = "standard", -- standard, strict, all, off, basic
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

            vim.lsp.config("roslyn_ls", {
                cmd = { "/home/em/.local/bin/roslyn/content/LanguageServer/linux-x64/Microsoft.CodeAnalysis.LanguageServer", "--logLevel", "Debug", "--extensionLogDirectory", "/home/em/temp/roslyn_ls/logs", "--stdio" },
                settings = {
                    ["csharp|background_analysis"] = {
                        dotnet_analyzer_diagnostics_scope = "fullSolution",
                        dotnet_compiler_diagnostics_scope = "fullSolution"
                    },
                    ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true
                    },
                    ["csharp|completion"] = {
                        dotnet_provide_regex_completions = true,
                        dotnet_show_completion_items_from_unimported_namespaces = true,
                        dotnet_show_name_completion_suggestions = true
                    },
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                        csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                        dotnet_enable_inlay_hints_for_indexer_parameters = true,
                        dotnet_enable_inlay_hints_for_literal_parameters = true,
                        dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                        dotnet_enable_inlay_hints_for_other_parameters = true,
                        dotnet_enable_inlay_hints_for_parameters = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                        dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true
                    },
                    ["csharp|symbol_search"] = {
                        dotnet_search_reference_assemblies = true
                    }
                }
            })

            local cmp_lsp = require("cmp_nvim_lsp")
            for _, server in ipairs(servers) do
                local capabilities = cmp_lsp.default_capabilities()
                vim.lsp.config(server, {
                    capabilities = capabilities,
                })
                vim.lsp.enable(server)
            end

            local statusline = require "usr.statusline"
            vim.api.nvim_create_autocmd("LspProgress", {
                callback = function(args)
                    statusline.set_lsp_progress(args.data.client_id, args.data.params.value)
                end
            })
        end
    }
}
