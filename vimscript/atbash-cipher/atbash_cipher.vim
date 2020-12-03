"
" Create an implementation of the atbash cipher, an ancient encryption system
" created in the Middle East.
"
" Examples:
"
"   :echo AtbashEncode('test')
"   gvhg
"
"   :echo AtbashDecode('gvhg')
"   test
"
"   :echo AtbashDecode('gsvjf rxpyi ldmul cqfnk hlevi gsvoz abwlt')
"   thequickbrownfoxjumpsoverthelazydog
"

function! AtbashDecode(cipher) abort
  let cipher_list = str2list(substitute(a:cipher, ' ', '', 'g'))

  for i in range(len(cipher_list))
    if cipher_list[i] > 96 && cipher_list[i] < 123
      let cipher_list[i] = 219 - cipher_list[i]
    endif
  endfor

  return list2str(cipher_list)
endfunction

function! AtbashEncode(plaintext) abort
  let text_list = str2list(substitute(tolower(a:plaintext), '[^a-z0-9]', '', 'g'))

  for i in range(len(text_list))
    if text_list[i] > 96 && text_list[i] < 123
      let text_list[i] = 219 - text_list[i]
    endif
  endfor

  let i = (len(text_list) - 1) / 5 * 5

  while i >= 5
    call insert(text_list, 32, i)
    let i -= 5
  endwhile

  return list2str(text_list)
endfunction
