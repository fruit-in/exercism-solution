"
" Given a DNA string, compute how many times each nucleotide occurs in the
" string.
"
" Examples:
"
"   :echo NucleotideCounts('ACGTACGT')
"   {'A': 2, 'C': 2, 'T': 2, 'G': 2}
"
"   :echo NucleotideCounts('ACGTXACGT')
"   E605: Exception not caught: Invalid nucleotide in strand
"

function! NucleotideCounts(strand) abort
  let counter = {'A': 0, 'C': 0, 'T': 0, 'G': 0}

  for i in range(len(a:strand))
    if !has_key(counter, a:strand[i])
      throw 'Invalid nucleotide in strand'
    endif
    let counter[a:strand[i]] += 1
  endfor

  return counter
endfunction
