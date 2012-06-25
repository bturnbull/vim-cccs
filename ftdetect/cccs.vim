au! BufRead,BufNewFile *.cs setfiletype cccs
au! BufRead,BufNewFile * call s:FTcccs()

" Detect a config spec by looking for lines starting with 'element'
function! s:FTcccs()
  if exists("b:current_syntax")
    return
  endif

  let i = 1
  while i < 50
    let line = getline(i)
    let i = i + 1
    if line =~ '^element'
      setfiletype cccs
      break
    endif
  endwhile
endfunction
