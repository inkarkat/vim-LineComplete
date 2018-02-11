" Test completion of space separated words with indent.

set completefunc=LineComplete#LineComplete
edit LineComplete.txt

source ../helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(2)
call IsMatchesInIsolatedLine('    if foo', ['if foo  " Level 1'], '>>1 match for foo')
call IsMatchesInIsolatedLine("\tif foo", ['if foo " Level 2.2'], '>>2 match for foo')
call vimtest#Quit()
