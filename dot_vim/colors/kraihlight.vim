" https://gist.github.com/1004856   -- 3 June 2011
set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "kraihlight"

hi Visual guibg=#404040 ctermbg=238
" Original kraih colour
" hi Cursor guibg=#b0d0f0 ctermbg=117

" Torte colour
" highlight Cursor guifg=Black        guibg=Green     gui=NONE
" highlight Cursor ctermfg=Black      ctermbg=Green   cterm=NONE

" zenburn colour
hi Cursor guifg=#000d18 guibg=#ff009f gui=bold
hi Cursor ctermfg=233   ctermbg=109     cterm=bold

hi Normal guifg=#f9f9f9 guibg=#131313 ctermfg=254 ctermbg=233
hi Underlined guifg=#f9f9f9 guibg=NONE gui=underline ctermfg=254
hi NonText guifg=#34383c guibg=NONE ctermfg=240
hi SpecialKey guifg=#303030 guibg=NONE ctermfg=239
hi LineNr guifg=#34383c guibg=NONE gui=NONE ctermfg=240
" hi StatusLine guifg=#34383c guibg=NONE gui=NONE ctermfg=240 cterm=NONE
" hi StatusLineNC guifg=#34383c guibg=NONE gui=NONE ctermfg=240 cterm=NONE
hi StatusLine       guifg=#34383c     guibg=#dedede     gui=italic    ctermfg=yellow      ctermbg=darkgray    cterm=NONE
hi StatusLineNC     guifg=#aaaaaa       guibg=#666666     gui=NONE      ctermfg=gray        ctermbg=darkgray    cterm=NONE  
hi VertSplit guifg=#303030 guibg=#303030 gui=NONE ctermfg=239 ctermbg=239
hi WildMenu guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254 ctermbg=NONE
hi Folded guifg=#8a9597 guibg=#34383c gui=NONE ctermfg=250
hi FoldColumn guifg=#8a9597 guibg=#34383c gui=NONE ctermfg=250
hi SignColumn guifg=#8a9597 guibg=#34383c gui=NONE ctermfg=250
" hi MatchParen guifg=#000000 guibg=#b0d0f0 gui=bold ctermfg=232
hi MatchParen guifg=#000000 guibg=#b0d0f0 gui=bold term=reverse ctermbg=white ctermfg=232 cterm=bold
hi ErrorMsg guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254
hi WarnMsg guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254
hi ModeMsg guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254
hi MoreMsg guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254
hi Question guifg=#f9f9f9 guibg=NONE gui=NONE ctermfg=254

hi Comment guifg=#726d73 gui=italic ctermfg=240
hi String guifg=#9fac7f ctermfg=150
hi Number guifg=#9fac7f ctermfg=150

hi Keyword guifg=#d6b67f ctermfg=215
hi PreProc guifg=#899ab4 ctermfg=110
hi Conditional guifg=#d6b67f ctermfg=216

hi Todo guifg=#899ab4 gui=italic,bold ctermfg=110
hi Constant guifg=#d08356 ctermfg=209

hi Identifier guifg=#899ab4 ctermfg=110
hi Function guifg=#ab8252 ctermfg=215
hi Type guifg=#d87d5f gui=bold ctermfg=209
hi Statement guifg=#d6b67f ctermfg=215 gui=NONE

hi Special guifg=#ac98ac ctermfg=225
hi Delimiter guifg=#f9f9f9 ctermfg=254
hi Operator guifg=#f9f9f9 ctermfg=254

" hi Title guifg=#ab8252 gui=underline ctermfg=215
hi Title guifg=#ab8252 gui=NONE ctermfg=215
hi Repeat guifg=#d6b67f ctermfg=215
hi Structure guifg=#d6b67f ctermfg=215

hi Directory guifg=#dad085 ctermfg=228
hi Error guibg=#602020 ctermfg=52

hi CursorLine     guifg=NONE        guibg=#161616     gui=NONE      ctermfg=NONE        ctermbg=234        cterm=BOLD
hi CursorColumn   guifg=NONE        guibg=#232323     gui=NONE      ctermfg=NONE        ctermbg=233        cterm=BOLD
hi LineNr         ctermfg=NONE      guifg=#555555     guibg=#000000

" Special for XML
hi link xmlTag          Keyword 
hi link xmlTagName      Conditional 
hi link xmlEndTag       Identifier 

" Special for HTML
hi link htmlTag         Keyword 
hi link htmlTagName     Conditional 
hi link htmlEndTag      Identifier 

" Special for Javascript
hi link javaScriptNumber      Number 

" Special for Python
hi  link pythonEscape         Keyword      

hi Search term=reverse ctermfg=252 ctermbg=60 cterm=bold,underline guifg=Black guibg=LightYellow
