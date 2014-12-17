" LineComplete.vim: Insert mode completion of entire lines based on looser matching.
"
" DEPENDENCIES:
"   - CompleteHelper.vim autoload script
"   - Complete/Abbreviate.vim autoload script
"   - Complete/Repeat.vim autoload script
"
" Copyright: (C) 2014 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.00.002	03-Apr-2014	FIX: For the fallbacks, don't require a match
"				after the relaxed base. Otherwise, the last base
"				WORD cannot be matched as the last WORD of a
"				line.
"	001	31-Mar-2014	file creation

function! s:GetCompleteOption()
    return (exists('b:LineComplete_complete') ? b:LineComplete_complete : g:LineComplete_complete)
endfunction
let s:save_cpo = &cpo
set cpo&vim

let s:repeatCnt = 0
function! LineComplete#LineComplete( findstart, base )
    if s:repeatCnt
	if a:findstart
	    return col('.') - 1
	else
	    let l:matches = []

	    " Need to translate the embedded ^@ newline into the \n atom.
	    let l:previousCompleteExpr = substitute(escape(s:fullText, '\'), '\n', '\\n', 'g')

	    " Avoid that the current position is matched, and the line after the
	    " cursor is returned as a completion candidate. As the pattern is
	    " applied to multiple buffers, we avoid atoms that directly
	    " reference the line or a mark, and instead exclude the literal text
	    " match.
	    let l:notNextLineExpr = '\%(' . escape(getline(line('.') + 1), '\') . '\n\)\@!'

	    call CompleteHelper#FindMatches(l:matches,
	    \   '\V\^' . s:indentExpr . l:previousCompleteExpr . '\zs\n' . l:notNextLineExpr . '\.\*',
	    \   {'complete': s:GetCompleteOption()}
	    \)
	    return l:matches
	endif
    endif

    if a:findstart
	" Locate the start of the alphabetic characters.
	let s:indentExpr = matchstr(getline('.'), '^\s\+')
	let l:startCol = len(s:indentExpr) + 1
	if empty(s:indentExpr)
	    " When there's no existing indent before the completion base, allow
	    " arbitrary indent for matching lines.
	    let s:indentExpr = '\s\*'
	endif

	return l:startCol - 1 " Return byte index, not column.
    else
	" Find matches having s:indentExpr and starting with a:base.
	let l:matches = []
	call CompleteHelper#FindMatches(l:matches,
	\   '\V\^' . s:indentExpr . '\zs' . (
	\       empty(a:base) ?
	\           '\S\.\*' :
	\           '\%(' .
	\               escape(a:base, '\') . '\.\+' .
	\           '\|' .
	\               '\%(\S\.\*\s\)' . escape(a:base, '\') . '\.\*' .
	\           '\)'
	\       ),
	\   {'complete': s:GetCompleteOption()}
	\)
	if empty(l:matches) && a:base =~# '\s'
	    " In case there are no matches, allow arbitrary text between each
	    " WORD in a:base.
	    echohl ModeMsg
	    echo '-- User defined completion (^U^N^P) -- Non-contiguous search...'
	    echohl None

	    let l:relaxedBase = substitute(escape(a:base, '\'), '\s\+', '\\%(&\\|\\s\\.\\*\\s\\)', 'g')
	    call CompleteHelper#FindMatches(l:matches,
	    \   '\V\^' . s:indentExpr . '\zs\%(\S\.\*\s\)\?' . l:relaxedBase . '\.\*',
	    \   {'complete': s:GetCompleteOption()}
	    \)
	endif

	if empty(l:matches)
	    echohl ModeMsg
	    echo '-- User defined completion (^U^N^P) -- Anywhere search...'
	    echohl None

	    let l:relaxedBase = substitute(escape(a:base, '\'), '\s\+', '\\.\\+', 'g')
	    call CompleteHelper#FindMatches(l:matches,
		\ '\V\^' . s:indentExpr . '\zs\%(\S\.\*\)\?' . l:relaxedBase . '\.\*',
		\ {'complete': s:GetCompleteOption()}
	    \)
	endif

	call map(l:matches, 'CompleteHelper#Abbreviate#Word(v:val)')
	return l:matches
    endif
endfunction

function! LineComplete#Expr()
    set completefunc=LineComplete#LineComplete

    let s:repeatCnt = 0 " Important!
    let [s:repeatCnt, l:addedText, s:fullText] = CompleteHelper#Repeat#TestForRepeat()
    return "\<C-x>\<C-u>"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
