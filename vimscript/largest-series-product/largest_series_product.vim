"
" Given a string of digits, calculate the largest product for a contiguous
" substring of digits of length n.
"
"   :echo LargestProduct('1234', 1)
"   4
"   :echo LargestProduct('1234', 2)
"   12
"   :echo LargestProduct('1234', 3)
"   24
"   :echo LargestProduct('1234', 4)
"   24
"

function! LargestProduct(digits, span) abort
  if match(a:digits, '[^0-9]') != -1
    throw 'invalid input'
  endif
  if len(a:digits) < a:span || a:span < 0
    return -1
  endif
  if a:span == 0
    return 1
  endif

  let digits = map(str2list(a:digits), 'v:val - 48')
  let max_product = 0

  for i in range(a:span - 1, len(digits) - 1)
    let product = reduce(digits[i - a:span + 1: i], {acc, val -> acc * val}, 1)
    let max_product = max([max_product, product])
  endfor

  return max_product
endfunction
