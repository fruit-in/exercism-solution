"
" Determine if a sentence is a pangram.
"
" A pangram is a sentence using every letter of the alphabet at least once.
"
" The alphabet used consists of ASCII letters a to z, inclusive, and is case
" insensitive. Input will not contain non-ASCII symbols.
"
" Example:
"
"     :echo IsPangram('The quick brown fox jumps over the lazy dog')
"     1
"     :echo IsPangram('The quick brown fox jumps over the lazy do')
"     0
"

function! IsPangram(sentence) abort
  let counter = repeat([0], 26)

  for ascii in filter(str2list(toupper(a:sentence)), 'v:val > 64 && v:val < 91')
    let counter[ascii - 65] += 1
  endfor

  return min(counter)
endfunction
