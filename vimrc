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

if &t_Co == 256
    colorscheme moria
else
    let g:CSApprox_loaded = 1
    colorscheme peaksea
endif   

" ---------------------------------------------------------------------- 
" Option specific for gvim
" ---------------------------------------------------------------------- 
if has("gui_running")
    " set gfn=Consolas\ 11   " default font
    set gfn=Droid\ Sans\ Mono\ Dotted\ 10
    set lsp=1              " number of pixels between line
    set guioptions-=T      " disable toolbard
    set guioptions-=r      " disable scrollbar
    set lines=60           " window height
    set columns=120        " window width
endif

" ---------------------------------------------------------------------- 
"  Default setting
" ---------------------------------------------------------------------- 
set ignorecase
set textwidth=80
set autoindent
set shiftwidth=4
set shiftround
set formatoptions=tcq2
set tabstop=4
set nohlsearch
set ruler                               " display cursor position on the bottom right
set nolist
set nocompatible                        " use Vim defaults (much better!)
set bs=2                                " allow backspacing over everything in insert mode
set ai                                  " always set autoindenting on
set viminfo='20,\"50                    " read/write a .viminfo file, don't store more than 50 lines of registers
set backup 
set backupext=.backup                   " will be named with an extension of .backup
set listchars=tab:>.,trail:x            " Set tab and EOL chacter and display tem...
set showcmd                             " show currently type command?
set showmatch                           " show matching parens?
set showmode                            " show current mode?
set mouse=a                             " mouse selection don't include number list
set selectmode=mouse
set laststatus=2                        " Status bar
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%=%-16(\ %l,%c-%v\ %)%P
syntax on
syn sync fromstart
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
" Retain visual block after indenting
" ---------------------------------------------------------------------- 
:vnoremap > >gv
:vnoremap < <gv

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

" Run perltidy in normal and visual mode
nnoremap ,pt  :%!perltidy -q<cr> " only work in 'normal' mode
vnoremap ,pt  :!perltidy -q<cr>  " only work in 'visual' mode

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


" ###################################################################### 
"                            Plugins
" ###################################################################### 

" ---------------------------------------------------------------------- 
" NERD_Tree config
" ---------------------------------------------------------------------- 
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
:let g:proj_flags="imstvcg"

" ---------------------------------------------------------------------- 
" Matchit
" ---------------------------------------------------------------------- 
runtime! macros/matchit.vim


" ---------------------------------------------------------------------- 
"  AutoComplPop (acp)
" ---------------------------------------------------------------------- 
let g:acp_behaviorSnipmateLength=1           " support snipmate
let g:acp_behaviorPerlOmniLength=1           " support omnicompletion (Moose, etc)
let g:acp_mappingDriven=1                    " disable cursor key
let g:acp_behaviorKeywordLength=3
let g:acp_behaviorFileLength=-1              " disable filename completion
let g:acp_behaviorRubyOmniMethodLength=-1    " disable ruby
let g:acp_behaviorPythonOmniLength=-1        " disable python


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
iab Ydated  <C-R>=strftime("%Y-%m-%d")<CR>
iab Ydatel  <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
iab Ydatetime   <C-R>=strftime("%Y%m%d %T")<CR>
iab Ytime   <C-R>=strftime("%H:%M")<CR>
iab Yfilepath   <C-R>=getcwd()."/".bufname(1)<CR>
iab Ysu sub {<CR>    my () = @_;<CR>}<CR><ESC>3k <ESC>l <ESC>i
iab Ype #!/usr/bin/perl<ESC>o<CR>use strict;<CR>use warnings;<CR><CR><ESC>j
iab Ymo package MyOwnPackage;<ESC>o<CR>use Moose; # turn on strict/warnings<CR><CR><ESC>j

" ---------------------------------------------------------------------- 
" Mappings
" ---------------------------------------------------------------------- 
map C 0i# <ESC>j    " comment
map U 0xx<ESC>j     " uncomment
map ,t   :call Notab()<cr>
map ,1   :call ToggleBackground()<cr>
map ,2   :call ToggleHLSearch()<cr>
map <F1> :call Syntax_toggle()<cr>
map <F2> :call AI_toggle()<cr>
nnoremap <Leader>H yyp^v$r-o<Esc>    " added dash underline by CTRL-H
map Q gq                             " don't use Ex mode, use Q for formatting
" imap {} {<CR>}<Esc>O               " Added closing bracket


" ---------------------------------------------------------------------- 
"  FUNCTIONS
" ---------------------------------------------------------------------- 

" toggle the hlsearch thing for when you can't find your cursor
:function ToggleHLSearch()
:  if (&hlsearch)
:    set nohlsearch
:    return ''
:  else
:    set hlsearch
:    return ''
:  endif
:endfunction

" toggle the syntax coloring
:function ToggleBackground()
:  if (&background=="dark")
:    set background=light
:    return ''
:  else
:    set background=dark
:    return ''
:  endif
:endfunction

:function Syntax_toggle()
:  if has("syntax_items")
:    syntax off
:  else
:    syntax on
:    syn sync fromstart
:    set background=dark
:    hi Comment term=bold ctermfg=DarkCyan
:  endif
:endfunction

let b:ai_flag = 1
:function AI_toggle() 
:  if b:ai_flag
:    set noautoindent
:    set textwidth=0
:    let b:ai_flag = 0
:  else
:    set autoindent
:    set textwidth=72
:    let b:ai_flag = 1
:  endif
:endfunction 

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
autocmd FileType perl,html,chtml,schtml,js set number

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


" ###################################################################### 
"  GPG/PGP
"
"  Enable editing of gpg files
"     read: set binary mode before reading the file, decypher text in buffer after reading
"    write: cypher file after writing
"   append: decypher file, append, cypher file
" ###################################################################### 

:augroup gpg
augroup gpg
  au!

  autocmd BufReadPre,FileReadPre      *.gpg set bin
  autocmd BufReadPost,FileReadPost    *.gpg let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost    *.gpg '[,']!gpg --no-secmem-warning --out=- -
  autocmd BufReadPost,FileReadPost    *.gpg set nobin
  autocmd BufReadPost,FileReadPost    *.gpg let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost    *.gpg execute ":doautocmd BufReadPost " . expand("%:r")
  autocmd BufWritePre,FileWritePre    *.gpg set bin|'[,']!gpg -c --no-secmem-warning --out=- -
  autocmd BufWritePre,FileWritePre    *.gpg !mv <afile> <afile>:r.bak
  autocmd BufWritePost,FileWritePost  *.gpg !chmod 600 <afile>
  autocmd BufWritePost,FileWritePost  *.gpg undo|set nobin
augroup END
