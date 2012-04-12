" ---------------------------------------------------------------------- 
"  Terminal
" ---------------------------------------------------------------------- 
if &term == 'xterm-256color'
    set t_Co=256
elseif &term == 'rxvt-unicode'  
    set t_Co=88
else
    set t_Co=16
endif


" ---------------------------------------------------------------------- 
" Option specific for gvim
" ---------------------------------------------------------------------- 
if has("gui_running")
    " set gfn=Consolas\ 11   " default font
    " set gfn=Droid\ Sans\ Mono\ Dotted\ 10
    set gfn=Envy\ Code\ R\ 11
    set lsp=1              " number of pixels between line
    set guioptions-=T      " disable toolbard
    set guioptions-=r      " disable scrollbar
    set lines=60           " window height
    set columns=120        " window width
    set go-=L
    set go-=T
    highlight Normal guibg=black guifg=white

    " Shift-Insert to copy clipboard to gvim
    set guioptions+=a
    nmap <S-Insert> "+gP
    imap <S-Insert> <ESC><S-Insert>i
    " vmap <C-C> "+y 
endif

" ---------------------------------------------------------------------- 
"  Default setting
" ---------------------------------------------------------------------- 
set encoding=utf-8
set wildignore+=*CVS
set textwidth=80
set tabstop=4
set shiftwidth=4
set shiftround                          " Always indent to the nearest tabstop
set smarttab                            " Use shiftwidths at left margin, tabstops everywhere else
set formatoptions=tcq2
set formatoptions-=cro
set wrapmargin=2                        " Wrap 2 characters from the edge of the window
set ruler                               " display cursor position on the bottom right
set nolist
set nocompatible                        " use Vim defaults (much better!)
set bs=2                                " allow backspacing over everything in insert mode
set smartindent
set ai                                  " always set autoindenting on
set viminfo='20,\"50                    " read/write a .viminfo file, don't store more than 50 lines of registers
set backup 
set backupext=.backup                   " will be named with an extension of .backup
set showcmd                             " show currently type command?
set showmatch                           " show matching parens?
set showmode                            " show current mode?
set scrolloff=5                         " 5 lines before and after cursor on top/bottom screen
set mouse=a                             " mouse selection don't include number list
set selectmode=mouse
set cursorline
set cursorcolumn
set undolevels=10
set laststatus=2                        " Status bar
set statusline=[%n]\ [FORMAT=%{&ff}]\ %<%.99f\ %h%w%m%r%y%=%-16(\ %l,%c-%v\ %)%P\ [ASCII=\%03.3b]\ [HEX=\%02.2B]
set modelines=0
syntax on
syn sync fromstart

" ---------------------------------------------------------------------- 
" [ Toggle visibility of naughty characters ]
" ---------------------------------------------------------------------- 

" Make naughty characters visible...
" (uBB is right double angle, uB7 id middle dot)
exec "set lcs=tab:\uBB\uBB,trail:\uB7,nbsp:~"

augroup VisibleNaughtiness
    au!
    au BufEnter * set list
    au BufEnter *.txt set nolist
    au BufEnter *.vp* set nolist
augroup END

" ---------------------------------------------------------------------- 
" [ Set up smarter search behaviour ]
" ---------------------------------------------------------------------- 
set incsearch  " Lookahead as search pattern specified
set ignorecase " Ignore case in all searches...
set smartcase  "...unless uppercase letters used
set hlsearch   " Highlight all search matches

" ---------------------------------------------------------------------- 
" [ Center the display line after searches. (This makes it *much* easier to see
"   the matched line) ]
"
" More info: http://www.vim.org/tips/tip.php?tip_id=528
" ---------------------------------------------------------------------- 
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" ---------------------------------------------------------------------- 
" [ There can be only one (one Vim session per file) ]
" ---------------------------------------------------------------------- 

augroup NoSimultaneousEdits
    au!
    au SwapExists * let v:swapchoice = 'o'
    au SwapExists * echohl ErrorMsg
    au SwapExists * echo 'Duplicate edit session (readonly)'
    au SwapExists * echohl None
    au SwapExists * sleep 2
augroup END

inoremap # X<C-H>#|                            " And no magic outdent for comments
nnoremap <silent> >> :call ShiftLine()<CR>|    " And no shift magic on comments

function! ShiftLine()
    set nosmartindent
    normal! >>
    set smartindent
endfunction

" ---------------------------------------------------------------------- 
" For performance -- automatic foldmethod makes vim very slow to autocomplete
" Sourced from vim tip: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
"
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
set complete-=i    " Disable searching for include files, boost performance

" ---------------------------------------------------------------------- 
"  PLUGIN: xml.vim - unfortunately it needs to be declared prior to
" filetype plugin on below.
" ---------------------------------------------------------------------- 
let xml_use_xhtml = 1

filetype on
filetype plugin on
filetype indent on


" ---------------------------------------------------------------------- 
" ACK integration for grep
" ---------------------------------------------------------------------- 
" set grepprg=ack
" set grepformat=%f:%l:%m


" ---------------------------------------------------------------------- 
" Set default value for letter capital-K 
" ---------------------------------------------------------------------- 
au BufReadPost *.pl   set keywordprg=perldoc\ -f
au BufReadPost *.pm   set keywordprg=perldoc\ -f
au BufReadPost *.vim  map K :exe ":help ".expand("<cword>")<CR>
au BufReadPost .vimrc map K :exe ":help ".expand("<cword>")<CR>

" ---------------------------------------------------------------------- 
"  Additional colours
" ---------------------------------------------------------------------- 
set background=dark                     
hi Comment term=NONE ctermfg=DarkCyan
highlight constant ctermfg=DarkGreen    


" ---------------------------------------------------------------------- 
" keep the swap file here.
" ---------------------------------------------------------------------- 
if has("win32") || has("win64")
    set directory=$TMP
else
    set directory=/tmp
end 

" ---------------------------------------------------------------------- 
" [ Make Visual modes work better ]
" ---------------------------------------------------------------------- 

" Visual Block mode is far more useful that Visual mode (so swap the commands)...
nnoremap v <C-V>
nnoremap <C-V> v

vnoremap v <C-V>
vnoremap <C-V> v

" Make BS/DEL work as expected in visual modes (i.e. delete elected)...
vmap <BS> x

"Square up visual selections...
set virtualedit=block

" ---------------------------------------------------------------------- 
" Retain visual block after indenting
" ---------------------------------------------------------------------- 

" When shifting, retain selection over multiple shifts...
vmap <expr> > KeepVisualSelection(">")
vmap <expr> < KeepVisualSelection("<")

function! KeepVisualSelection(cmd)
    if mode() ==# "V"
        return a:cmd . "gv"
    else
        return a:cmd
    endif
endfunction



" ---------------------------------------------------------------------- 
"  Perl specific
" ---------------------------------------------------------------------- 

" let perl_nofold_packages=1
let perl_fold=1
let perl_want_scope_in_variables=1
let perl_extended_vars=1
let perl_include_pod=1
let perl_sync_dist=250
map ,pc  :!perl -c %

" ---------------------------------------------------------------------- 
" [ Handle Perl include files better ]
" ---------------------------------------------------------------------- 

set include=^\\s*use\\s\\+\\zs\\k\\+\\ze
set includeexpr=substitute(v:fname,'::','/','g')
set suffixesadd=.pm
execute 'set path+=' . substitute($PERL5LIB, ':', ',', 'g')

" Run perltidy in normal and visual mode
nnoremap ,pt  :%!perltidy -q<cr> " only work in 'normal' mode
vnoremap ,pt  :!perltidy -q<cr>  " only work in 'visual' mode

" Extract long subroutine into inner sub
vnoremap ,ext :!~/files/bin/extract_sub <cr>

" Adjust keyword characters for Perlish identifiers...
set iskeyword+=$
set iskeyword+=%
set iskeyword+=@
set iskeyword-=,

" Execute Perl file (output to pager)...
nmap E :!mperl -w %<CR>


" =====[ Auto-setup for Perl scripts and modules ]===========

augroup Perl_Setup
    au!
    au BufNewFile *.p[lm] 0r !file_template <afile>
    au BufNewFile *.p[lm] /^[ \t]*[#].*implementation[ \t]\+here/
augroup END

" ---------------------------------------------------------------------- 
" expandtab is commented out below as we want to set it only on specific
" FileType via SetCodingStyle()
" ---------------------------------------------------------------------- 
" set expandtab

" ---------------------------------------------------------------------- 
" Workaround for Cygwin
" ---------------------------------------------------------------------- 
" let g:netrw_cygwin=1
" let g:netrw_scp_cmd="/usr/bin/scp"
" let g:netrw_liststyle=3
" let g:netrw_browse_split=4
" set t_ti= t_te=

" ---------------------------------------------------------------------- 
" [ Miscellaneous features (mainly options) ]
" ---------------------------------------------------------------------- 

set nomore      " Don't page long listings
set autowrite   " Save buffer automatically when changing files
set autoread    " Always reload buffer when external changes detected

"           +--Disable hlsearch while loading viminfo
"           |  +--Remember marks for last 50 files
"           |  |      +--Remember up to 1000 lines in each register
"           |  |      |   +--Remember up to 1MB in each register
"           |  |      |   |      +--Remember last 1000 search patterns
"           |  |      |   |      |    +---Remember last 100 commands
"           |  |      |   |      |    |
"           v  v      v   v      v    v
set viminfo=h,'50,<10000,s1000,/1000,:100

set backspace=indent,eol,start    " BS past autoindents, line boundaries,
                                  " and even the start of insertion

set fileformats=unix,mac,dos      " Handle Mac and DOS line-endings
                                  " but prefer Unix endings

set wildmode=list:longest,full    " Show list of completions
                                " and complete as much as possible then iterate full completions

set noshowmode                    " Suppress mode change messages

" Use space to jump down a page (like browsers do)...
nnoremap <Space> <PageDown> 

" ###################################################################### 
"                            Plugins
" ###################################################################### 

" ---------------------------------------------------------------------- 
" NERD_Tree config
" ---------------------------------------------------------------------- 
let NERDTreeShowLineNumbers=1
let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2
let NERDTreeIgnore=['CVS']
let NERDTreeWinPos="right"
let NERDTreeWinSize=35
map <F10> :NERDTreeToggle<CR>


" ---------------------------------------------------------------------- 
" tasklisk plugin (TODO, FIXME, XXX, etc)
" ---------------------------------------------------------------------- 
let g:tlWindowPosition = 1
map T :TaskList<CR>


" ---------------------------------------------------------------------- 
"  Taglist (tag for subroutine, method, class, etc)
" ---------------------------------------------------------------------- 
nnoremap <silent> <F9> :TlistToggle<CR>
let Tlist_Exit_OnlyWindow=1    " close vim if taglist is the only window
let Tlist_Use_Right_Window=1   " window on the right
let Tlist_Enable_Fold_Column=0 " dont show folding
let tlist_perl_settings='perl;c:constants;l:labels;p:package;s:subroutines;o:pod;a:attribute;b:blocks'
set tags=tags;/


" ---------------------------------------------------------------------- 
" Setting for Project 
" ---------------------------------------------------------------------- 
" :let g:proj_flags="imstvcg"

" ---------------------------------------------------------------------- 
" Matchit
" ---------------------------------------------------------------------- 
runtime! macros/matchit.vim


" ---------------------------------------------------------------------- 
"  AutoComplPop (acp)
" ---------------------------------------------------------------------- 
" let g:acp_behaviorSnipmateLength=1           " support snipmate
" let g:acp_behaviorPerlOmniLength=2           " support omnicompletion (Moose, etc) after 5 chars
" let g:acp_mappingDriven=1                    " disable cursor key
" let g:acp_behaviorKeywordLength=4
" let g:acp_behaviorKeywordIgnores=["use","sub"]   " ignore use as Perl uses too many "use" and "sub"
" let g:acp_behaviorFileLength=-1              " disable filename completion
" let g:acp_behaviorRubyOmniMethodLength=-1    " disable ruby
" let g:acp_behaviorPythonOmniLength=-1        " disable python
" let g:acp_ignorecaseOption=-1                " do not ignore case
" let g:acp_completeoptPreview=0

let g:omni_syntax_group_exclude_perl = 'perlPOD'    " disable POD on omni completion
let g:perlomni_export_functions = 1


" ---------------------------------------------------------------------- 
" perldoc2.vim (colorize perldoc)
" ---------------------------------------------------------------------- 
let g:Perldoc_path='/tmp/'
map <F8> :Perldoc<CR>


" ---------------------------------------------------------------------- 
" minibufexplorer setting
" ---------------------------------------------------------------------- 
" let g:miniBufExplMapWindowNavVim = 1
" let g:miniBufExplMapWindowNavArrows = 1
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplModSelTarget = 1 

" ---------------------------------------------------------------------- 
" Thesaurus & autocorrect -- disabled, it makes slow
" ---------------------------------------------------------------------- 
" set thesaurus+=/home/et6339/.vim/thesaurus/mthesaur.txt
" :source ~/.vim/autocorrect/autocorrect.vim


" ---------------------------------------------------------------------- 
" ABBREVIATIONS
" ---------------------------------------------------------------------- 
:ab Yruler #234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
iab Ydate   <C-R>=strftime("%Y%m%d")<CR>
iab Ydated  <C-R>=strftime("%d-%m-%Y")<CR>
iab Ydatel  <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
iab Ydatetime   <C-R>=strftime("%Y%m%d %T")<CR>
iab Ytime   <C-R>=strftime("%H:%M")<CR>
iab Yfilepath   <C-R>=getcwd()."/".bufname(1)<CR>
iab Ysu sub {<CR>    my () = @_;<CR>}<CR><ESC>3k <ESC>l <ESC>i
iab Ype #!/usr/bin/env perl<ESC>o<CR>use common::sense;<CR><CR><ESC>j
iab Ymo package MyOwnPackage;<ESC>o<CR>use Moose; # turn on strict/warnings<CR><CR><ESC>j

"=====[ Correct common mistypings in-the-fly ]=======================

iab retrun return
iab pritn print
iab teh the
iab liek like
iab liekwise likewise
iab Pelr Perl
iab pelr perl
iab ;t 't
iab moer more
iab previosu previous

" ---------------------------------------------------------------------- 
" Mappings
" ---------------------------------------------------------------------- 
map ,t   :call Notab()<cr>
nnoremap <Leader>H yyp^v$r-o<Esc>    " added dash underline by CTRL-H
map Q gq                             " don't use Ex mode, use Q for formatting


" ---------------------------------------------------------------------- 
"  FUNCTIONS
" ---------------------------------------------------------------------- 

" function to set coding style 
:function SetCodingStyle()
:  set tabstop=4
:  set expandtab
:endfunction

" HTML file
:function SetHtmlStyle()
:  set tabstop=4
:  set expandtab
:  set textwidth=0
:endfunction

:function Notab()
:  set ts=4 expandtab
:  %retab!
:endfunction

" Highlight a column in csv text.
" :Csv 1    " highlight first column
" :Csv 12   " highlight twelfth column
" :Csv 0    " switch off highlight
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)

" ---------------------------------------------------------------------- 
"  [ Remove trailing spaces automatically ]
" ---------------------------------------------------------------------- 
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
nmap _= :call Preserve("normal gg=G")<CR>


" ---------------------------------------------------------------------- 
" [ Convert file to different tabspacings ]
" ---------------------------------------------------------------------- 

function! NewTabSpacing (newtabsize)
    " Preserve expansion, if expanding...
    let was_expanded = &expandtab

    " But convert to tabs initially...
    normal TT

    " Change the tabsizing...
    execute "set ts=" . a:newtabsize
    execute "set sw=" . a:newtabsize

    " Update the formatting commands to mirror than new tabspacing...
    execute "map F !Gformat -T" . a:newtabsize . " -"
    execute "map <silent> f !Gformat -T" . a:newtabsize . "<CR>"

    " Re-expand, if appropriate...
    if was_expanded
        normal TS
    endif
endfunction

" Note, these are all T-<SHIFTED-DIGIT>, which is easier to type...
map <silent> T@ :call NewTabSpacing(2)<CR>
map <silent> T# :call NewTabSpacing(3)<CR>
map <silent> T$ :call NewTabSpacing(4)<CR>
map <silent> T% :call NewTabSpacing(5)<CR>
map <silent> T^ :call NewTabSpacing(6)<CR>
map <silent> T& :call NewTabSpacing(7)<CR>
map <silent> T* :call NewTabSpacing(8)<CR>

" Convert to/from spaces/tabs...
map <silent> TS :set expandtab<CR>:%retab!<CR>
map <silent> TT :set noexpandtab<CR>:%retab!<CR>


" ---------------------------------------------------------------------- 
" [ Add or subtract comments ]
" ---------------------------------------------------------------------- 

" Work out what the comment character is, by filetype...
au BufNewFile,BufRead * let b:cmt = exists('b:cmt') ? b:cmt : ''
au FileType *sh,awk,python,perl,perl6,ruby let b:cmt = exists('b:cmt') ? b:cmt : '# '
au FileType vim let b:cmt = exists('b:cmt') ? b:cmt : '"'

" Work out whether the line has a comment tehn reverse that condition...
function! ToggleComment ()
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '# '

    " Grab the line and work out whether it's commented...
    let currline = getline(".")

    " If so, remove it and rewrite the line...
    if currline =~ '^' . comment_char
        let repline = substitute(currline, '^' . comment_char, "", "")
        call setline(".", repline)

    " Otherwise, insert it...
    else
        let repline = substitute(currline, '^', comment_char, "")
        call setline(".", repline)
    endif
endfunction

" Toggle comments down an entire visual selection of lines...
function! ToggleBlock () range
    " What's the comment character???
    let comment_char = exists('b:cmt') ? b:cmt : '# '

    " Start at the first line...
    let linenum = a:firstline

    " Get all the lines, and decide their comment state by examining the first...
    let currline = getline(a:firstline, a:lastline)
    if currline[0] =~ '^' . comment_char
        " If the first line is commented, decomment all...
        for line in currline
            let repline = substitute(line, '^' . comment_char, "", "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    else
        " Otherwise, encomment all...
        for line in currline
            let repline = substitute(line, '^\('. comment_char . '\)\?', comment_char, "")
            call setline(linenum, repline)
            let linenum += 1
        endfor
    endif
endfunction

" Set up the relevant mappings
nmap <silent> # :call ToggleComment()<CR>j0
vmap <silent> # :call ToggleBlock()<CR>


" ---------------------------------------------------------------------- 
"  AUTOCOMMAND for each file type
" ---------------------------------------------------------------------- 
autocmd FileType sh call SetCodingStyle()
autocmd FileType perl call SetCodingStyle()
au FileType perl,sh,php set cin cinkeys=0{,0},:,!^F,o,O,e comments=s1:/*,mb:*,ex:*/,://,b:#,:%,:XCOMM,n:>,fb:-
autocmd FileType html call SetHtmlStyle()
autocmd FileType chtml call SetHtmlStyle()
autocmd FileType schtml call SetHtmlStyle()
autocmd FileType js call SetCodingStyle()
autocmd FileType css call SetCodingStyle()
autocmd BufRead todo.html set ts=8 tw=64
autocmd BufRead /tmp/cvs set ts=8 et tw=64
autocmd FileType perl,html,chtml,schtml,js,c set number
" autocmd Filetype perl setlocal omnifunc=syntaxcomplete#Complete


" .(s)chtml file 
autocmd BufNewFile,BufRead *.inc setf html
autocmd BufNewFile,BufRead *.chtml setf html
autocmd BufNewFile,BufRead *.schtml setf html

autocmd BufReadPost /tmp/crd.diff :map <F1> :call Notab()

" In text files, always limit the width of text to 78 characters
autocmd BufRead *.txt set tw=64 

" In email files, always limit the width of text to 64 characters
autocmd BufRead mutt-* set tw=64

autocmd BufRead *.frm set expandtab ts=8
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif


" Color scheme must be the last line
" set bg=dark
" colorscheme ir_black2
colorscheme kraihlight

" ---------------------------------------------------------------------- 
" [Make the completion popup look menu-ish on a Mac]
" ---------------------------------------------------------------------- 
highlight Pmenu guibg=white guifg=black gui=NONE ctermbg=white ctermfg=black
highlight PmenuSel guibg=#899ab4 guifg=white gui=BOLD ctermbg=blue ctermfg=white cterm=bold
highlight PmenuSbar guibg=grey guifg=grey gui=NONE ctermbg=grey ctermfg=grey
highlight PmenuThumb guibg=#899ab4 guifg=#899ab4 gui=NONE ctermbg=blue ctermfg=blue

