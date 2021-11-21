" LineComplete.vim: Insert mode completion of entire lines based on looser matching.
"
" DEPENDENCIES:
"   - Requires Vim 7.0 or higher.
"   - LineComplete.vim autoload script
"
" Copyright: (C) 2014-2015 Ingo Karkat
"   The VIM LICENSE applies to this script; see ':help copyright'.
"
" Maintainer:	Ingo Karkat <ingo@karkat.de>
"
" REVISION	DATE		REMARKS
"   1.01.002	12-Jan-2015	Remove default g:LineComplete_complete
"				configuration and default to 'complete' option
"				value instead.
"   1.00.001	31-Mar-2014	file creation

" Avoid installing twice or when in unsupported Vim version.
if exists('g:loaded_LineComplete') || (v:version < 700)
    finish
endif
let g:loaded_LineComplete = 1

"- mappings --------------------------------------------------------------------

inoremap <silent> <expr> <Plug>(LineComplete) LineComplete#Expr()
if ! hasmapto('<Plug>(LineComplete)', 'i')
    imap <C-x>l <Plug>(LineComplete)
endif

" vim: set ts=8 sts=4 sw=4 noexpandtab ff=unix fdm=syntax :
