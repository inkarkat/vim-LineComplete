" Test completion of space separated words without indent.

set completefunc=LineComplete#LineComplete
edit LineComplete.txt

runtime tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(5)

call IsMatchesInIsolatedLine('does not exist', [], 'no matches for does not exist')
call IsMatchesInIsolatedLine('brown fox', ['The quick brown fox jumps'], 'subsequent match for brown fox')
call IsMatchesInIsolatedLine('fast fox', ['The fast brown red fox drags'], 'separated match for fast fox')
call IsMatchesInIsolatedLine('quick fox', ['The quick brown fox jumps'], 'matches for quick fox')
call IsMatchesInIsolatedLine('the dog.', ['over the very-lazy dog.'], 'match for the dog.')

call vimtest#Quit()
