"
" Given a phrase, return a dictionary containing the count of occurrences of
" each word.
"
" Example:
"
"   :echo WordCount('olly olly in come free')
"   {'olly': 2, 'come': 1, 'in': 1, 'free': 1}
"
function! WordCount(phrase) abort
  let phrase = substitute(tolower(a:phrase), '[^''a-z0-9]', ' ', 'g')
  let words = filter(map(split(phrase, ' '), 'trim(v:val, "''")'), 'len(v:val) > 0')
  let counter = {}

  for word in words
    if !has_key(counter, word)
      let counter[word] = 0
    endif
    let counter[word] += 1
  endfor

  return counter
endfunction
