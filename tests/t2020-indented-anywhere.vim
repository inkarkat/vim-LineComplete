" Test completion of words anywhere with indent.

set completefunc=LineComplete#LineComplete
edit LineComplete.txt

runtime tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(3)

call IsMatchesInIsolatedLine("\t. , !", [], 'no >>2 match for . , !')
call IsMatchesInIsolatedLine("\tf .2", ['if foo " Level 2.2'], '>>2 match for f .2')
call IsMatchesInIsolatedLine("        . , !", ['if foo " Level 2.3, spaced!'], '>>2 match for . , !')

call vimtest#Quit()
