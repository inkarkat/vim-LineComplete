" Test completion of subsequent words without indent.

set completefunc=LineComplete#LineComplete
edit LineComplete.txt

source ../helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(4)
call IsMatchesInIsolatedLine('doesnotexist', [], 'no matches for doesnotexist')
call IsMatchesInIsolatedLine('quick', ['The quick brown fox jumps', 'The quick hare watches', 'The quickest way to happiness', 'A quick,quack,quuck!'], 'matches for quick')
call IsMatchesInIsolatedLine('The quick ', ['The quick brown fox jumps', 'The quick hare watches'], 'matches for The quick<Space>')
call IsMatchesInIsolatedLine('very-la tag', ['as the very-large dog-house tags along.'], 'match for very-la tag')
call vimtest#Quit()
