---@param plugin string
---@param opts? {colorscheme: string?, opts: table?, callback: fun()}
---@return table
local function theme(plugin, opts)
    return {
        plugin,
        priority = 1000,
        config = function()
            local slash = string.find(plugin, "/", 1, true)
            local dot_ext = 0
            for _, ext in ipairs({ ".vim", ".nvim" }) do
                local result = string.find(plugin, ext, 1, true)
                if result ~= nil then
                    dot_ext = result
                    break
                end
            end
            local name = string.sub(plugin, slash + 1, dot_ext - 1)
            opts = opts or {}
            if opts.opts ~= nil then
                require(name).setup()
            end
            local callback = opts.callback or function()
                vim.cmd.colorscheme(opts.colorscheme or name)
            end
            callback()
        end
    }
end

return {
    -- theme("rebelot/kanagawa.nvim", {colorscheme = "kanagawa-dragon", opts = {} }),
    -- theme("rebelot/kanagawa.nvim", {colorscheme = "kanagawa-wave", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "nightfox", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "terafox", opts = {} }),
    -- theme("EdenEast/nightfox.nvim", {colorscheme = "nordfox", opts = {} }),
    -- theme("vague2k/vague.nvim", { opts = {} }),
    -- theme("yorumicolors/yorumi.nvim"),
    -- theme("wtfox/jellybeans.nvim"),
    -- theme("wtfox/jellybeans.nvim", {colorscheme = "jellybeans-mono" }),
    -- theme("wtfox/jellybeans.nvim", {colorscheme = "jellybeans-muted" }),
    -- theme("p00f/alabaster.nvim"),
    -- theme("alligator/accent.vim", {
    --     callback = function()
    --         vim.cmd([[
    --             let g:accent_colour = "yellow"
    --             source ~/.local/share/nvim/lazy/accent.vim/colors/accent.vim
    --         ]])
    --     end
    -- }),
    -- theme("davidosomething/vim-colors-meh", { colorscheme = "meh" }),
    -- theme("axvr/photon.vim"),
    -- theme("kvrohit/rasmus.nvim", {
    --     callback = function()
    --         vim.cmd([[
    --             let g:rasmus_italic_functions = 0
    --             let g:rasmus_bold_functions = 0
    --             colorscheme rasmus
    --         ]])
    --     end
    -- }),
    {
        "https://github.com/tjdevries/colorbuddy.nvim",
        lazy = true,
        priority = 1000,
        config = function()
            local buddy = require "colorbuddy"

            buddy.Color.new('background', "#2E3440")
            buddy.Color.new('fg', "#292929")
            buddy.Color.new('nord_0', "#2E3440")
            buddy.Color.new('nord_1', "#3B4252")
            buddy.Color.new('nord_2', "#434C5E")
            buddy.Color.new('nord_3', "#4C566A")
            buddy.Color.new('nord_3_light', "#616E88")
            buddy.Color.new('nord_4', "#D8DEE9")
            buddy.Color.new('nord_5', "#E5E9F0")
            buddy.Color.new('nord_6', "#ECEFF4")
            buddy.Color.new('nord_7', "#8FBCBB")
            buddy.Color.new('nord_8', "#88C0D0")
            buddy.Color.new('nord_9', "#81A1C1")
            buddy.Color.new('nord_10', "#5E81AC")
            buddy.Color.new('nord_11', "#BF616A")
            buddy.Color.new('nord_12', "#D08770")
            buddy.Color.new('nord_13', "#EBCB8B")
            buddy.Color.new('nord_14', "#A3BE8C")
            buddy.Color.new('nord_15', "#B48EAD")

            buddy.Color.new('white', '#D8DEE9')
            buddy.Color.new('red', '#BF616A')
            buddy.Color.new('green', '#A3BE8C')
            buddy.Color.new('yellow', '#EBCB8B')
            buddy.Color.new('blue', '#81A1C1')
            buddy.Color.new('aqua', '#A3BE8C')
            buddy.Color.new('cyan', '#8FBCBB')
            buddy.Color.new('purple', '#B48EAD')
            buddy.Color.new('violet', '#B48EAD')
            buddy.Color.new('orange', '#D08770')

            -- my highlight
            buddy.Group.new('TabLineSel', buddy.colors.nord_0, buddy.colors.nord_9, buddy.styles.italic)
            buddy.Group.new('TabLineSelSeparator', buddy.colors.nord_9, buddy.colors.nord_0)
            buddy.Group.new('TabLine', buddy.colors.fg, buddy.colors.nord_2)
            buddy.Group.new('TabLineSeparator', buddy.colors.nord_2, buddy.colors.fg)
            buddy.Group.new('TabLineFill', buddy.colors.none, buddy.colors.none)

            buddy.Group.new('Conceal', buddy.colors.nord_3_light, buddy.colors.none)
            buddy.Group.new('VertSplit', buddy.colors.nord_3, buddy.colors.none)

            buddy.Group.new('Normal', buddy.colors.background, buddy.colors.none)
            buddy.Group.new('Function', buddy.colors.nord_8, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new('Error', buddy.colors.nord_11, buddy.colors.none, buddy.styles.bold)
            buddy.Group.new('ErrorMsg', buddy.colors.nord_5, buddy.colors.nord_11, buddy.styles.bold)
            buddy.Group.new('WarningMsg', buddy.colors.nord_5, buddy.colors.nord_12, buddy.styles.bold)
            buddy.Group.new('Boolean', buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new('Character', buddy.colors.nord_14, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new('Comment', buddy.colors.nord_3_light, buddy.colors.none, buddy.styles.italic)
            buddy.Group.new("Conditional", buddy.colors.nord_9, buddy.colors.none, buddy.styles.italic)
            buddy.Group.new("Constant", buddy.colors.nord_4, buddy.colors.none, buddy.styles.italic)
            buddy.Group.new("Define", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Delimiter", buddy.colors.nord_6, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Exception", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Float", buddy.colors.nord_15, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Function", buddy.colors.nord_8, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Identifier", buddy.colors.nord_4, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Include", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Keyword", buddy.colors.nord_7, buddy.colors.none, buddy.styles.italic)
            buddy.Group.new("Label", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Number", buddy.colors.nord_15, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Operator", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("PreProc", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Repeat", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Special", buddy.colors.nord_4, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("SpecialChar", buddy.colors.nord_13, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("SpecialComment", buddy.colors.nord_8, buddy.colors.none, buddy.styles.italic)
            buddy.Group.new("Statement", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("StorageClass", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("String", buddy.colors.nord_14, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Structure", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Tag", buddy.colors.nord_4, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Title", buddy.colors.nord_4, buddy.colors.none)
            buddy.Group.new("Todo", buddy.colors.nord_13, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Type", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Typedef", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("CursorColumn", buddy.colors.nord_1, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("LineNr", buddy.colors.nord_9, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("CursorLineNr", buddy.colors.nord_5, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("Line", buddy.colors.nord_12, buddy.colors.none, buddy.styles.bold)
            buddy.Group.new("SignColumn", buddy.colors.none, buddy.colors.none, buddy.styles.NONE)
            buddy.Group.new("StatusLine", buddy.colors.nord_8, buddy.colors.nord_3, buddy.styles.NONE)

            buddy.Group.new("buddy.ColorColumn", buddy.colors.none, buddy.colors.nord_1)
            buddy.Group.new("Cursor", buddy.colors.nord_0, buddy.colors.nord_4)
            buddy.Group.new("CursorLine", buddy.colors.none, buddy.colors.none)
            buddy.Group.new("iCursor", buddy.colors.nord_0, buddy.colors.nord_4)
            buddy.Group.new("EndOfBuffer", buddy.colors.none, buddy.colors.none)
            buddy.Group.new("MatchParen", buddy.colors.nord_8, buddy.colors.nord_3)
            buddy.Group.new("NonText", buddy.colors.none, buddy.colors.none)
            buddy.Group.new("PMenu", buddy.colors.nord_4, buddy.colors.nord_2)
            buddy.Group.new("PmenuSbar", buddy.colors.nord_4, buddy.colors.nord_2)
            buddy.Group.new("PMenuSel", buddy.colors.nord_6, buddy.colors.nord_9)
            buddy.Group.new("PmenuThumb", buddy.colors.nord_8, buddy.colors.nord_3)
            buddy.Group.new("SpecialKey", buddy.colors.nord_3, buddy.colors.nord_3)
            buddy.Group.new("SpellBad", buddy.colors.nord_11, buddy.colors.nord_0)
            buddy.Group.new("SpellCap", buddy.colors.nord_13, buddy.colors.nord_0)
            buddy.Group.new("SpellLocal", buddy.colors.nord_5, buddy.colors.nord_0)
            buddy.Group.new("SpellRare", buddy.colors.nord_6, buddy.colors.nord_0)
            buddy.Group.new("Visual", buddy.colors.nord_4, buddy.colors.nord_9)
            buddy.Group.new("VisualNOS", buddy.colors.nord_2, buddy.colors.nord_1)
            buddy.Group.new("Folded", buddy.colors.nord_14, buddy.colors.none, buddy.styles.italic)

            -- "+- Neovim Support -+
            buddy.Group.new("healthError", buddy.colors.nord_11, buddy.colors.nord_1)
            buddy.Group.new("healthSuccess", buddy.colors.nord_14, buddy.colors.nord_1)
            buddy.Group.new("healthWarning", buddy.colors.nord_13, buddy.colors.nord_1)
            buddy.Group.new("TermCursorNC", buddy.colors.nord_1, buddy.colors.nord_1)
            buddy.Group.new("IncSearch", buddy.colors.nord_6, buddy.colors.nord_10, buddy.styles.underline)
            buddy.Group.new("Search", buddy.colors.nord_1, buddy.colors.nord_8)

            -- vim
            buddy.Group.new('vimcommand', buddy.groups.Statement, buddy.colors.none)
            buddy.Group.new('vimLet', buddy.groups.vimcommand, buddy.colors.none)
            buddy.Group.new('vimFuncVar', buddy.groups.identifier, buddy.colors.none)
            buddy.Group.new('vimCommentTitle', buddy.groups.PreProc, buddy.colors.none)
            buddy.Group.new('vimIsCommand', buddy.colors.none, buddy.colors.none)
            buddy.Group.new('vimFuncSID', buddy.groups.Special, buddy.colors.none)
            buddy.Group.new('vimMapModKey', buddy.groups.vimFuncSID, buddy.colors.none)
            buddy.Group.new('vimMapLhs', buddy.colors.none, buddy.colors.none)
            buddy.Group.new('vimNotation', buddy.colors.nord_7, buddy.colors.none)
            buddy.Group.new('vimBracket', buddy.groups.Delimiter, buddy.colors.none)
            buddy.Group.new('vimMap', buddy.groups.vimcommand, buddy.colors.none)
            buddy.Group.new('nvimMap', buddy.groups.vimMap, buddy.colors.none)

            -- startify
            buddy.Group.new("StartifyFile", buddy.colors.nord_6, buddy.colors.none)
            buddy.Group.new("StartifyFooter", buddy.colors.none, buddy.colors.none)
            buddy.Group.new("StartifyHeader", buddy.colors.nord_8, buddy.colors.none)
            buddy.Group.new("StartifyNumber", buddy.colors.nord_7, buddy.colors.none)
            buddy.Group.new("StartifyPath", buddy.colors.nord_8, buddy.colors.none)
            buddy.Group.new("StartifyBracket", buddy.groups.Delimiter, buddy.groups.Delimiter)
            buddy.Group.new("StartifySlash", buddy.groups.Normal, buddy.groups.Normal)
            buddy.Group.new("StartifySpecial", buddy.groups.Comment, buddy.groups.Comment)

            -- gitgutter
            buddy.Group.new("GitGutterAdd", buddy.colors.nord_14, buddy.colors.none)
            buddy.Group.new("GitGutterDelete", buddy.colors.nord_11, buddy.colors.none)
            buddy.Group.new("GitGutterChange", buddy.colors.nord_13, buddy.colors.none)
            buddy.Group.new("GitGutterChangeDelete", buddy.colors.nord_11, buddy.colors.none)

            -- built-in LSP
            buddy.Group.new("DiagnosticWarn", buddy.colors.nord_13, buddy.colors.none)
            buddy.Group.new("DiagnosticError", buddy.colors.nord_11, buddy.colors.none)
            buddy.Group.new("DiagnosticInfo", buddy.colors.nord_8, buddy.colors.none)
            buddy.Group.new("DiagnosticHint", buddy.colors.nord_10, buddy.colors.none)

            buddy.Group.new("LSPReferenceText", buddy.colors.none, buddy.colors.none)
            buddy.Group.new("LSPReferenceRead", buddy.colors.none, buddy.colors.none, buddy.styles.bold)
            buddy.Group.new("LSPReferenceWrite", buddy.colors.nord_9, buddy.colors.none, buddy.styles.bold)

            -- Markdown
            buddy.Group.new("markdownError", buddy.colors.nord_4, buddy.colors.none)

            buddy.Group.new("CmpItemAbbr", buddy.colors.nord_4, buddy.colors.none)
            buddy.Group.new("CmpItemKind", buddy.colors.nord_13, buddy.colors.none)
            buddy.Group.new("CmpItemMenu", buddy.colors.nord_7, buddy.colors.none)
        end
    },
    -- {
    --     "redbug312/cactusbuddy",
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require("colorbuddy").colorscheme("cactusbuddy")
    --     end
    -- },
    {
        "kyazdani42/nvim-web-devicons",
        lazy = false,
        opts = {
            override = {
                luamarkdown = {
                    icon = "󰽛",
                    name = "luamarkdown"
                }
            },
            override_by_extension = {
                ["luamd"] = {
                    icon = "󰽛",
                    name = "luamarkdown"
                }
            }
        }
    },
}
