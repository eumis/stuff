local M = {}

local ensure = {
    --'ada',
    --'agda',
    --'arduino',
    --'astro',
    --'awk',
    'bash',
    --'bass',
    --'beancount',
    --'bibtex',
    --'bicep',
    --'blueprint',
    --'c',
    'c_sharp',
    --'cairo',
    --'capnp',
    --'chatito',
    --'clojure',
    --'cmake',
    --'comment',
    'commonlisp',
    --'cooklang',
    --'corn',
    --'cpon',
    'cpp',
    'css',
    --'cuda',
    --'cue',
    --'d',
    --'dart',
    --'devicetree',
    --'dhall',
    'diff',
    'dockerfile',
    'dot',
    --'ebnf',
    --'eex',
    --'elixir',
    'elm',
    --'elsa',
    --'elvish',
    --'embedded_template',
    --'erlang',
    --'fennel',
    --'firrtl',
    'fish',
    --'foam',
    --'fortran',
    --'fsh',
    --'func',
    --'fusion',
    --'gdscript',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'git_config',
    'gitignore',
    --'gleam',
    --'glimmer',
    --'glsl',
    'go',
    --'godot_resource',
    --'gomod',
    --'gosum',
    --'gowork',
    --'groovy',
    --'graphql',
    --'hack',
    --'hare',
    'haskell',
    'haskell_persistent',
    --'hcl',
    --'heex',
    'hjson',
    --'hlsl',
    --'hocon',
    --'hoon',
    'html',
    'htmldjango',
    'http',
    'hurl',
    'ini',
    --'ispc',
    --'janet_simple',
    'java',
    'javascript',
    --'jq',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'jsonnet',
    --'julia',
    --'kdl',
    'kotlin',
    --'lalrpop',
    --'latex',
    --'ledger',
    --'llvm',
    'lua',
    'luadoc',
    'luap',
    'luau',
    --'m68k',
    --'make',
    'markdown',
    'markdown_inline',
    --'matlab',
    --'menhir',
    --'mermaid',
    --'meson',
    --'mlir',
    --'nickel',
    --'ninja',
    --'nix',
    --'norg',
    --'objc',
    'ocaml',
    'ocaml_interface',
    --'ocamllex',
    --'odin',
    'org',
    --'pascal',
    --'passwd',
    --'pem',
    --'perl',
    --'php',
    --'phpdoc',
    --'lis',
    --'pioasm',
    --'po',
    --'poe_filter',
    --'pony',
    --'prisma',
    --'promql',
    --'proto',
    --'prql',
    --'pug',
    --'puppet',
    'python',
    'ql',
    --'qmldir',
    --'qmljs',
    'query',
    'r',
    --'racket',
    --'rasi',
    'regex',
    --'rego',
    --'rnoweb',
    --'robot',
    --'ron',
    --'rst',
    --'ruby',
    'rust',
    --'scala',
    --'scfg',
    --'scheme',
    'scss',
    'slint',
    --'smali',
    --'smithy',
    --'solidity',
    --'sparql',
    'sql',
    --'squirrel',
    --'starlark',
    --'supercollider',
    --'surface',
    --'svelte',
    --'swift',
    --'sxhkdrc',
    --'systemtap',
    --'t32',
    --'tablegen',
    --'teal',
    --'terraform',
    --'thrift',
    --'tiger',
    --'tlaplus',
    'todotxt',
    'toml',
    'tsx',
    --'turtle',
    --'twig',
    'typescript',
    --'ungrammar',
    'usd',
    --'uxntal',
    --'v',
    --'vala',
    --'verilog',
    --'vhs',
    'vim',
    'vimdoc',
    'vue',
    --'wgsl',
    --'wgsl_bevy',
    --'wing',
    'yaml',
    --'yang',
    --'yuck',
    'zig'
}

function M.setup()
    require 'nvim-treesitter.install'.compilers = { "zig", "gcc", "clang" }
    require 'nvim-treesitter.configs'.setup {
        -- One of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = ensure,

        -- Install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,

        auto_install = false,

        -- List of parsers to ignore installing
        ignore_install = {},

        highlight = {
            -- `false` will disable the whole extension
            enable = true,

            -- list of language that will be disabled
            disable = {},

            -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
            -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
            -- Using this option may slow down your editor, and you may see some duplicate highlights.
            -- Instead of true it can also be a list of languages
            additional_vim_regex_highlighting = false,
        },
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = nil, -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        }
    }
    local ft_to_lang = require('nvim-treesitter.parsers').ft_to_lang
    require('nvim-treesitter.parsers').ft_to_lang = function(ft)
        if ft == 'zsh' then
            return 'bash'
        end
        return ft_to_lang(ft)
    end
end

return M
