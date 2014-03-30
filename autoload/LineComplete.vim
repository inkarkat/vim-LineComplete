" LineComplete.vim: Insert mode completion of entire lines based on looser matching.
"
" DEPENDENCIES:
"   - CompleteHelper.vim autoload script
"   - Complete/Repeat.vim autoload script
"
" Copyright: (C) 2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"	001	31-Mar-2014	file creation

function! s:GetCompleteOption()
    return (exists('b:LineComplete_complete') ? b:LineComplete_complete : g:LineComplete_complete)
endfunction

let s:repeatCnt = 0
function! LineComplete#LineComplete( findstart, base )
    if s:repeatCnt
	if a:findstart
	    return col('.') - 1
	else
	    let l:matches = []
echomsg '****' '\V\^' . s:indent . escape(s:fullText, '\') . '\n\zs\.\*'
	    call CompleteHelper#FindMatches(l:matches, '\V\^' . s:indent . escape(s:fullText, '\') . '\zs\n\.\*', {'complete': s:GetCompleteOption()})
	    return l:matches
	endif
    endif

    if a:findstart
	" Locate the start of the alphabetic characters.
	let s:indent = matchstr(getline('.'), '^\s\+')
	return len(s:indent) " Return byte index, not column.
    else
	" Find matches having s:indent and starting with a:base.
	let l:matches = []
	call CompleteHelper#FindMatches(l:matches, '\V\^' . s:indent . '\zs' . (empty(a:base) ? '\S\.\*' : escape(a:base, '\') . '\.\+'), {'complete': s:GetCompleteOption()})
	if empty(l:matches) && a:base =~# '\s'
	    " In case there are no matches, allow arbitrary text between each
	    " WORD in a:base.
	    echohl ModeMsg
	    echo '-- User defined completion (^U^N^P) -- Relaxed search...'
	    echohl None

	    let l:relaxedBase = substitute(escape(a:base, '\'), '\s\+', '\\%(&\\|\\s\\.\\*\\s\\)', 'g')
	    call CompleteHelper#FindMatches(l:matches, '\V\^' . s:indent . '\zs' . l:relaxedBase . '\.\+', {'complete': s:GetCompleteOption()})
	endif
	return l:matches
    endif
endfunction

function! LineComplete#Expr()
    set completefunc=LineComplete#LineComplete

    let s:repeatCnt = 0 " Important!
    let [s:repeatCnt, l:addedText, s:fullText] = CompleteHelper#Repeat#TestForRepeat()

    return "\<C-x>\<C-u>"
endfunction

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
