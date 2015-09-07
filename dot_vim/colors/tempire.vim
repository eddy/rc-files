set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "tempire"
set linespace=2

hi Visual guibg=#404040 ctermbg=238
hi Cursor guibg=#b0d0f0 ctermbg=117

hi Normal guifg=#f9f9f9 guibg=#141414 ctermfg=254
hi Underlined guifg=#f9f9f9 guibg=NONE gui=underline ctermfg=254
hi NonText guifg=#34383c guibg=NONE ctermfg=240
hi SpecialKey guifg=#303030 guibg=NONE ctermfg=239
hi LineNr guifg=#34383c guibg=NONE gui=NONE ctermfg=240
hi StatusLine guifg=black guibg=#666666 gui=NONE
hi StatusLineNC guifg=#666666 guibg=#333333 gui=NONE
hi VertSplit guifg=#303030 guibg=#303030 gui=NONE ctermfg=239 ctermbg=239
hi WildMenu guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254 ctermbg=NONE
hi Folded guifg=#8a9597 guibg=#34383c gui=NONE ctermfg=250
hi FoldColumn guifg=#8a9597 guibg=#34383c gui=NONE ctermfg=250
hi SignColumn guifg=#8a9597 guibg=#34383c gui=NONE ctermfg=250
"hi MatchParen guifg=NONE guibg=#a2a96f gui=bold ctermfg=232
hi MatchParen      guifg=#f0f0c0 guibg=#383838 gui=bold ctermfg=232
hi ErrorMsg guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254
hi WarnMsg guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254
hi ModeMsg guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254
hi MoreMsg guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254
hi Question guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254

hi Comment guifg=#726d73 gui=italic ctermfg=240
hi String guifg=#9fac7f ctermfg=150
hi Number guifg=#9fac7f ctermfg=150

hi Keyword guifg=#d6b67f ctermfg=215
"hi Keyword guifg=#F0EDA3 ctermfg=215
hi PreProc guifg=#899ab4 ctermfg=110
hi Conditional guifg=#d6b67f ctermfg=216

hi Todo guifg=#899ab4 gui=italic,bold ctermfg=110
hi Constant guifg=#d08356 ctermfg=209

hi Identifier guifg=#899ab4 ctermfg=110
hi Function guifg=#ab8252 ctermfg=215
hi Type guifg=#d87d5f gui=bold ctermfg=209
hi Statement guifg=#d6b67f ctermfg=215
"hi Statement guifg=#F0EDA3 ctermfg=215

hi Special guifg=#ac98ac ctermfg=225
hi Delimiter guifg=#f9f9f9 ctermfg=254
hi Operator guifg=#f9f9f9 ctermfg=254

" hi Title guifg=#ab8252 gui=underline ctermfg=215
hi Title guifg=#ef5939 ctermfg=166
hi Repeat guifg=#d6b67f ctermfg=215
hi Structure guifg=#d6b67f ctermfg=215

" hi Directory guifg=#dad085 ctermfg=228
hi Directory guifg=#A6E22E gui=bold ctermfg=118 cterm=bold
hi Error guibg=#602020 ctermfg=52
"
hi CursorLine guifg=NONE guibg=#000000 gui=none ctermfg=NONE ctermbg=232 cterm=BOLD
" hi CursorColumn guifg=NONE guibg=#000000 gui=none
hi CursorColumn   guifg=NONE        guibg=#232323     gui=NONE      ctermfg=NONE        ctermbg=233        cterm=BOLD
"hi Pmenu guifg=#602020 guibg=gray30
"hi Pmenu guifg=#000000 guibg=#9CBBDE gui=bold
hi Pmenu guifg=#ffffff guibg=#0087AF gui=bold
"hi PmenuSel guifg=#000000 guibg=#602020
hi PmenuSel guifg=#000000 guibg=#ffffff
"""" hi ColorColumn guifg=NONE guibg=#303030 gui=NONE ctermfg=239 ctermbg=239

