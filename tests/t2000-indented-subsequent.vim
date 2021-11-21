" Test completion of subsequent words with indent.

set completefunc=LineComplete#LineComplete
edit LineComplete.txt

runtime tests/helpers/completetest.vim
call vimtest#StartTap()
call vimtap#Plan(6)

call IsMatchesInIsolatedLine('    doesnotexist', [], 'no >>1 matches for doesnotexist')
call IsMatchesInIsolatedLine('    The quick', ['The quick brown fox jumps', 'The quick hare watches'], '>>1 matches for The quick')
call IsMatchesInIsolatedLine('    foo', ['if foo  " Level 1'], '>>1 match for foo')
call IsMatchesInIsolatedLine("\tfoo", ['if foo " Level 2.2'], '>>2 match for foo')
call IsMatchesInIsolatedLine("        foo", ['if foo " Level 2.3, spaced!'], '>>2 match for foo')
call IsMatchesInIsolatedLine("\t    echo", ['echo "foobar"', 'echo "nono"'], '>>3 match for echo')

call vimtest#Quit()
