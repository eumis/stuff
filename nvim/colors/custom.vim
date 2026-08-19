hi clear
let g:colors_name = 'custom'

let s:t_Co = has('gui_running') ? 16777216 : str2nr(&t_Co)
let s:tgc = has('termguicolors') && &termguicolors

hi! link Boolean Constant
hi! link CursorLineFold FoldColumn
hi! link CursorLineSign SignColumn
hi! link Debug Special
hi! link Define PreProc
hi! link Float Constant
hi! link Ignore Comment
hi! link IncSearch CurSearch
hi! link LineNrAbove LineNr
hi! link LineNrBelow LineNr
hi! link Number Constant
hi! link PopupBorder PmenuBorder
hi! link PopupNotification WarningMsg
hi! link PreCondit PreProc
hi! link SpecialChar Special
hi! link SpecialComment Special
hi! link SpecialKey NonText
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC
hi! link Terminal Normal
hi! link Typedef Type

hi Normal guifg=#cdd6f4 guibg=#1e1e2e guisp=NONE gui=NONE ctermfg=189 ctermbg=233 cterm=NONE term=NONE
hi Added guifg=#a6e3a1 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE term=NONE
hi Bold guifg=NONE guibg=NONE guisp=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold term=bold
hi Changed guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi Character guifg=#94e2d5 guibg=NONE guisp=NONE gui=NONE ctermfg=158 ctermbg=NONE cterm=NONE term=NONE
hi ColorColumn guifg=NONE guibg=#181825 guisp=NONE gui=NONE ctermfg=NONE ctermbg=232 cterm=NONE term=reverse
hi Comment guifg=#9399b2 guibg=NONE guisp=NONE gui=NONE ctermfg=103 ctermbg=NONE cterm=NONE term=bold
hi Conceal guifg=#7f849c guibg=NONE guisp=NONE gui=NONE ctermfg=102 ctermbg=NONE cterm=NONE term=NONE
hi Conditional guifg=#cba6f7 guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE term=NONE
hi Constant guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=216 ctermbg=NONE cterm=NONE term=NONE
hi CurSearch guifg=#cdd6f4 guibg=#89556b guisp=NONE gui=NONE ctermfg=189 ctermbg=126 cterm=NONE term=reverse
hi Cursor guifg=#1e1e2e guibg=#f5e0dc guisp=NONE gui=NONE ctermfg=233 ctermbg=224 cterm=NONE term=reverse
hi CursorColumn guifg=NONE guibg=#181825 guisp=NONE gui=NONE ctermfg=NONE ctermbg=232 cterm=NONE term=NONE
hi CursorIM guifg=#1e1e2e guibg=#cba6f7 guisp=NONE gui=NONE ctermfg=233 ctermbg=183 cterm=NONE term=NONE
hi CursorLine guifg=NONE guibg=#45475a guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE term=underline
hi CursorLineNr guifg=#b4befe guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE term=bold
hi Delimiter guifg=#9399b2 guibg=NONE guisp=NONE gui=NONE ctermfg=103 ctermbg=NONE cterm=NONE term=NONE
hi DiffAdd guifg=NONE guibg=#364143 guisp=NONE gui=NONE ctermfg=NONE ctermbg=22 cterm=NONE term=reverse
hi DiffChange guifg=NONE guibg=#25293c guisp=NONE gui=NONE ctermfg=NONE ctermbg=235 cterm=NONE term=NONE
hi DiffDelete guifg=NONE guibg=#443244 guisp=NONE gui=NONE ctermfg=NONE ctermbg=52 cterm=NONE term=reverse
hi DiffText guifg=NONE guibg=#3e4b6b guisp=NONE gui=NONE ctermfg=NONE ctermbg=23 cterm=NONE term=reverse
hi Directory guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi EndOfBuffer guifg=#45475a guibg=NONE guisp=NONE gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE term=NONE
hi Error guifg=#f38ba8 guibg=NONE guisp=NONE gui=NONE ctermfg=211 ctermbg=NONE cterm=NONE term=bold,reverse
hi ErrorMsg guifg=#f38ba8 guibg=NONE guisp=NONE gui=bold ctermfg=211 ctermbg=NONE cterm=bold term=bold,reverse
hi Exception guifg=#cba6f7 guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE term=NONE
hi FoldColumn guifg=#6c7086 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE term=NONE
hi Folded guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi Function guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi Identifier guifg=#b4befe guibg=NONE guisp=NONE gui=NONE ctermfg=181 ctermbg=NONE cterm=NONE term=NONE
hi Include guifg=#cba6f7 guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE term=NONE
hi Italic guifg=NONE guibg=NONE guisp=NONE gui=italic ctermfg=NONE ctermbg=NONE cterm=italic term=italic
hi Keyword guifg=#cba6f7 guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE term=NONE
hi Label guifg=#74c7ec guibg=NONE guisp=NONE gui=NONE ctermfg=117 ctermbg=NONE cterm=NONE term=NONE
hi LineNr guifg=#6c7086 guibg=NONE guisp=NONE gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE term=NONE
hi Macro guifg=#cba6f7 guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE term=NONE
hi MatchParen guifg=#fab387 guibg=NONE guisp=NONE gui=bold ctermfg=216 ctermbg=NONE cterm=bold term=bold,underline
hi ModeMsg guifg=#cdd6f4 guibg=NONE guisp=NONE gui=bold ctermfg=189 ctermbg=NONE cterm=bold term=bold
hi MoreMsg guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi NonText guifg=#6c7086 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE term=NONE
hi Operator guifg=#89dceb guibg=NONE guisp=NONE gui=NONE ctermfg=116 ctermbg=NONE cterm=NONE term=NONE
hi Pmenu guifg=#9399b2 guibg=#181825 guisp=NONE gui=NONE ctermfg=103 ctermbg=232 cterm=NONE term=reverse
hi PmenuBorder guifg=#b4befe guibg=#181825 guisp=NONE gui=NONE ctermfg=147 ctermbg=232 cterm=NONE term=NONE
hi PmenuExtra guifg=#6c7086 guibg=#181825 guisp=NONE gui=NONE ctermfg=59 ctermbg=232 cterm=NONE term=reverse
hi PmenuExtraSel guifg=#6c7086 guibg=#313244 guisp=NONE gui=bold ctermfg=59 ctermbg=236 cterm=bold term=bold
hi PmenuMatch guifg=#cdd6f4 guibg=NONE guisp=NONE gui=bold ctermfg=189 ctermbg=NONE cterm=bold term=bold
hi PmenuMatchSel guifg=#cdd6f4 guibg=NONE guisp=NONE gui=bold ctermfg=189 ctermbg=NONE cterm=bold term=bold
hi PmenuSbar guifg=NONE guibg=#313244 guisp=NONE gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE term=reverse
hi PmenuSel guifg=NONE guibg=#313244 guisp=NONE gui=bold ctermfg=NONE ctermbg=236 cterm=bold term=bold
hi PmenuThumb guifg=NONE guibg=#6c7086 guisp=NONE gui=NONE ctermfg=NONE ctermbg=59 cterm=NONE term=NONE
hi Popup guifg=#cdd6f4 guibg=#181825 guisp=NONE gui=NONE ctermfg=189 ctermbg=232 cterm=NONE term=NONE
hi PopupTitle guifg=#a6adc8 guibg=#181825 guisp=NONE gui=NONE ctermfg=146 ctermbg=232 cterm=NONE term=NONE
hi PreInsert guifg=#9399b2 guibg=NONE guisp=NONE gui=NONE ctermfg=103 ctermbg=NONE cterm=NONE term=NONE
hi PreProc guifg=#f5c2e7 guibg=NONE guisp=NONE gui=NONE ctermfg=225 ctermbg=NONE cterm=NONE term=NONE
hi Question guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=standout
hi QuickFixLine guifg=NONE guibg=#52476a guisp=NONE gui=bold ctermfg=189 ctermbg=60 cterm=bold term=NONE
hi Removed guifg=#f38ba8 guibg=NONE guisp=NONE gui=NONE ctermfg=211 ctermbg=NONE cterm=NONE term=NONE
hi Repeat guifg=#cba6f7 guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE term=NONE
hi Search guifg=#cdd6f4 guibg=#3e5767 guisp=NONE gui=NONE ctermfg=189 ctermbg=24 cterm=NONE term=reverse
hi SignColumn guifg=#45475a guibg=NONE guisp=NONE gui=NONE ctermfg=240 ctermbg=NONE cterm=NONE term=reverse
hi Special guifg=#f5c2e7 guibg=NONE guisp=NONE gui=NONE ctermfg=225 ctermbg=NONE cterm=NONE term=NONE
hi SpellBad guifg=NONE guibg=NONE guisp=#f38ba8 gui=undercurl ctermfg=211 ctermbg=NONE cterm=underline term=underline
hi SpellCap guifg=NONE guibg=NONE guisp=#f9e2af gui=undercurl ctermfg=222 ctermbg=NONE cterm=underline term=underline
hi SpellLocal guifg=NONE guibg=NONE guisp=#89b4fa gui=undercurl ctermfg=111 ctermbg=NONE cterm=underline term=underline
hi SpellRare guifg=NONE guibg=NONE guisp=#a6e3a1 gui=undercurl ctermfg=114 ctermbg=NONE cterm=underline term=underline
hi Statement guifg=#cba6f7 guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE term=NONE
hi StatusLine guifg=#cdd6f4 guibg=#11111b guisp=NONE gui=bold ctermfg=189 ctermbg=16 cterm=bold term=bold,reverse
hi StatusLineNC guifg=#6c7086 guibg=#181825 guisp=NONE gui=NONE ctermfg=59 ctermbg=232 cterm=NONE term=bold,underline
hi StorageClass guifg=#f9e2af guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=NONE
hi String guifg=#a6e3a1 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE term=NONE
hi Structure guifg=#cdd6f4 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=NONE
hi TabLine guifg=#6c7086 guibg=#11111b guisp=NONE gui=NONE ctermfg=59 ctermbg=16 cterm=NONE term=bold,underline
hi TabLineFill guifg=NONE guibg=#181825 guisp=NONE gui=NONE ctermfg=NONE ctermbg=232 cterm=NONE term=NONE
hi TabLineSel guifg=#cdd6f4 guibg=#1e1e2e guisp=NONE gui=NONE ctermfg=189 ctermbg=233 cterm=NONE term=bold,reverse
hi Tag guifg=#b4befe guibg=NONE guisp=NONE gui=bold ctermfg=147 ctermbg=NONE cterm=bold term=bold
hi Title guifg=#89b4fa guibg=NONE guisp=NONE gui=bold ctermfg=111 ctermbg=NONE cterm=bold term=NONE
hi TitleBar guifg=#cdd6f4 guibg=#181825 guisp=NONE gui=NONE ctermfg=189 ctermbg=232 cterm=NONE term=NONE
hi TitleBarNC guifg=#6c7086 guibg=#11111b guisp=NONE gui=NONE ctermfg=59 ctermbg=16 cterm=NONE term=NONE
hi Todo guifg=#f2cdcd guibg=NONE guisp=NONE gui=bold ctermfg=181 ctermbg=NONE cterm=bold term=bold,reverse
hi ToolbarButton guifg=#f5e0dc guibg=NONE guisp=NONE gui=NONE ctermfg=224 ctermbg=NONE cterm=NONE term=bold,reverse
hi ToolbarLine guifg=NONE guibg=NONE guisp=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE term=reverse
hi Type guifg=#cdd6f4 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=NONE
hi Underlined guifg=NONE guibg=NONE guisp=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline term=underline
hi VertSplit guifg=#b4befe guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE term=NONE
hi VertSplitNC guifg=#11111b guibg=NONE guisp=NONE gui=NONE ctermfg=16 ctermbg=NONE cterm=NONE term=NONE
hi Visual guifg=NONE guibg=#45475a guisp=NONE gui=NONE ctermfg=240 ctermbg=189 cterm=reverse term=reverse
hi VisualNOS guifg=NONE guibg=#45475a guisp=NONE gui=bold ctermfg=NONE ctermbg=240 cterm=bold term=NONE
hi WarningMsg guifg=#f9e2af guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=standout
hi WildMenu guifg=NONE guibg=#6c7086 guisp=NONE gui=NONE ctermfg=NONE ctermbg=59 cterm=NONE term=bold
hi csvCol0 guifg=#f38ba8 guibg=NONE guisp=NONE gui=NONE ctermfg=211 ctermbg=NONE cterm=NONE term=NONE
hi csvCol1 guifg=#fab387 guibg=NONE guisp=NONE gui=NONE ctermfg=216 ctermbg=NONE cterm=NONE term=NONE
hi csvCol2 guifg=#f9e2af guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=NONE
hi csvCol3 guifg=#a6e3a1 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE term=NONE
hi csvCol4 guifg=#89dceb guibg=NONE guisp=NONE gui=NONE ctermfg=116 ctermbg=NONE cterm=NONE term=NONE
hi csvCol5 guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi csvCol6 guifg=#b4befe guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE term=NONE
hi csvCol7 guifg=#cba6f7 guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE term=NONE
hi csvCol8 guifg=#f5c2e7 guibg=NONE guisp=NONE gui=NONE ctermfg=225 ctermbg=NONE cterm=NONE term=NONE
hi debugBreakpoint guifg=#6c7086 guibg=#1e1e2e guisp=NONE gui=NONE ctermfg=59 ctermbg=233 cterm=NONE term=NONE
hi debugPC guifg=NONE guibg=#11111b guisp=NONE gui=NONE ctermfg=NONE ctermbg=16 cterm=NONE term=NONE
hi diffAdded guifg=#a6e3a1 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE term=NONE
hi diffChanged guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi diffFile guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi diffIndexLine guifg=#94e2d5 guibg=NONE guisp=NONE gui=NONE ctermfg=158 ctermbg=NONE cterm=NONE term=NONE
hi diffLine guifg=#6c7086 guibg=NONE guisp=NONE gui=NONE ctermfg=59 ctermbg=NONE cterm=NONE term=NONE
hi diffNewFile guifg=#fab387 guibg=NONE guisp=NONE gui=NONE ctermfg=216 ctermbg=NONE cterm=NONE term=NONE
hi diffOldFile guifg=#f9e2af guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=NONE
hi diffRemoved guifg=#f38ba8 guibg=NONE guisp=NONE gui=NONE ctermfg=211 ctermbg=NONE cterm=NONE term=NONE
hi lCursor guifg=#1e1e2e guibg=#f38ba8 guisp=NONE gui=NONE ctermfg=233 ctermbg=211 cterm=NONE term=NONE
hi markdownCode guifg=#f2cdcd guibg=NONE guisp=NONE gui=NONE ctermfg=181 ctermbg=NONE cterm=NONE term=NONE
hi markdownCodeBlock guifg=#f2cdcd guibg=NONE guisp=NONE gui=NONE ctermfg=181 ctermbg=NONE cterm=NONE term=NONE
hi markdownH1 guifg=#f38ba8 guibg=NONE guisp=NONE gui=NONE ctermfg=211 ctermbg=NONE cterm=NONE term=NONE
hi markdownH2 guifg=#fab387 guibg=NONE guisp=NONE gui=NONE ctermfg=216 ctermbg=NONE cterm=NONE term=NONE
hi markdownH3 guifg=#f9e2af guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=NONE
hi markdownH4 guifg=#a6e3a1 guibg=NONE guisp=NONE gui=NONE ctermfg=114 ctermbg=NONE cterm=NONE term=NONE
hi markdownH5 guifg=#74c7ec guibg=NONE guisp=NONE gui=NONE ctermfg=117 ctermbg=NONE cterm=NONE term=NONE
hi markdownH6 guifg=#b4befe guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE term=NONE
hi markdownHeadingDelimiter guifg=#fab387 guibg=NONE guisp=NONE gui=bold ctermfg=216 ctermbg=NONE cterm=bold term=bold
hi markdownLinkText guifg=#89b4fa guibg=NONE guisp=NONE gui=underline ctermfg=111 ctermbg=NONE cterm=underline term=underline
hi qfFileName guifg=#89b4fa guibg=NONE guisp=NONE gui=NONE ctermfg=111 ctermbg=NONE cterm=NONE term=NONE
hi qfLineNr guifg=#f9e2af guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE term=NONE

if s:tgc || s:t_Co >= 256
  if s:tgc
    hi QuickFixLine cterm=NONE
    hi SpellBad guifg=#f38ba8 guibg=NONE ctermfg=211 ctermbg=NONE cterm=underline
    hi SpellCap guifg=#f9e2af guibg=NONE ctermfg=222 ctermbg=NONE cterm=underline
    hi SpellLocal guifg=#89b4fa guibg=NONE ctermfg=111 ctermbg=NONE cterm=underline
    hi SpellRare guifg=#a6e3a1 guibg=NONE ctermfg=114 ctermbg=NONE cterm=underline
    hi Visual cterm=NONE
  endif
  finish
endif

if s:t_Co >= 0
  hi CursorLineFold term=underline
  hi CursorLineSign term=underline
  hi Float term=NONE
  hi Ignore term=NONE
  hi IncSearch term=bold,reverse,underline
  hi Number term=NONE
  hi SpecialKey term=bold
  hi StatusLineTerm term=bold,reverse
  hi StatusLineTermNC term=bold,underline
  hi Terminal term=NONE
  finish
endif

" vim: et ts=8 sw=2 sts=2
