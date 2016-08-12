let s:bcs = b:current_syntax

unlet b:current_syntax
syntax include @SQL syntax/sql.vim
let b:current_syntax = s:bcs
" match optional, surrounding single or double quote and any whitespace in the heredoc name
syntax region perlHereDocSQL matchgroup=Statement start=+<<\(['"]\?\)\z(\s*SQL\s*\)\1+ end=+^\z1$+ contains=@SQL

" unlet b:current_syntax
" syntax include @SQL syntax/sql.vim
" syntax region sqlSnip matchgroup=Snip start=:<<\(['"]\?\)SQL\1\s*;\s*$: end=:^\s*SQL$: contains=@SQL
" 
" unlet b:current_syntax
" syntax include @XML syntax/xml.vim
" syntax region xmlSnip matchgroup=Snip start=:<<\(['"]\?\)XML\1\s*;\s*$: end=:^\s*XML$: contains=@XML
" 
" unlet b:current_syntax
" syntax include @HTML syntax/html.vim
" syntax region htmlSnip matchgroup=Snip start=:<<\(['"]\?\)HTML\1\s*;\s*$: end=:^\s*HTML$: contains=@HTML
" 
" hi link Snip SpecialComment
