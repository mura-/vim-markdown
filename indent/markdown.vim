if exists("b:did_indent") | finish | endif
let b:did_indent = 1

setlocal indentexpr=GetMkdIndent()
setlocal nolisp
setlocal nosmartindent
setlocal autoindent

" Only define the function once
if exists("*GetMkdIndent") | finish | endif

function! s:is_li_start(line)
    return a:line !~ '^ *\([*-]\)\%( *\1\)\{2}\%( \|\1\)*$' &&
      \    (a:line =~ '^\s*[*+-]\s\+' || a:line =~ '^\s*\d\+\.\s\+')
endfunction

function GetMkdIndent()
    let list_ind = shiftwidth
    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)
    " At the start of the file use zero indent.
    if lnum == 0 | return 0 | endif
    let ind = indent(lnum)
    let line = getline(lnum)    " Last line
    if v:lnum - lnum < 2
        return indent(lnum)
    else
        return 0
    endif
endfunction
