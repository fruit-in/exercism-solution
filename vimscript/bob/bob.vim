"
" This function takes any remark and returns Bob's response.
"
function! Response(remark) abort
  let question = trim(a:remark) =~# '?$'
  let yell = a:remark =~# '[A-Z]' && a:remark !~# '[a-z]'
  let nothing = len(trim(a:remark)) == 0

  if question && !yell
    return 'Sure.'
  elseif !question && yell
    return 'Whoa, chill out!'
  elseif question && yell
    return 'Calm down, I know what I''m doing!'
  elseif nothing
    return 'Fine. Be that way!'
  else
    return 'Whatever.'
endfunction
