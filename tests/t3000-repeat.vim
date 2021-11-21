" Test repeat of line completion.

runtime tests/helpers/insert.vim
view LineComplete.txt
new

call SetCompletion("\<C-x>l")
call SetCompleteExpr('LineComplete#Expr')

call InsertRepeat('    The ', 2, 0, 0, 0)
call InsertRepeat('function', 0, 0, 0, 0)

call vimtest#SaveOut()
call vimtest#Quit()
