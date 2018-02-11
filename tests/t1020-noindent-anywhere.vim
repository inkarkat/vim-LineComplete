" Test completion of words anywhere without indent.

set completefunc=LineComplete#LineComplete
edit LineComplete.txt

source ../helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(5)
call IsMatchesInIsolatedLine('do fox', [], 'no matches for do fox')
call IsMatchesInIsolatedLine('Level foo', [], 'no matches for Level foo')
call IsMatchesInIsolatedLine('y-l a', ['as the very-large dog-house tags along.'], 'match for y-l a')
call IsMatchesInIsolatedLine(', ,', ['A quick,quack,quuck!'], 'match for , ,')
call IsMatchesInIsolatedLine(', , !', ['A quick,quack,quuck!'], 'match for , , !')
call vimtest#Quit()
