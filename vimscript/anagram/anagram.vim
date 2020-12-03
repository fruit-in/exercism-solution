"
" Given a word and a list of possible anagrams, select the correct sublist.
"
" Example:
"
"   :echo FindAnagrams(['foo', 'bar', 'oof', 'Ofo'], 'foo')
"   ['Ofo', 'oof']
"
function! FindAnagrams(candidates, subject) abort
  let subject_list = sort(str2list(tolower(a:subject)))
  let anagrams = []

  for candidate in a:candidates
    let candidate_list = sort(str2list(tolower(candidate)))
    if candidate !=? a:subject && candidate_list == subject_list
      call add(anagrams, candidate)
    endif
  endfor

  return anagrams
endfunction
