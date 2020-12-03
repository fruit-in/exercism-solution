"
" Write a function to convert Arabic numbers to Roman numerals.
"
" Examples:
"
"   :echo ToRoman(1990)
"   MCMXC
"
"   :echo ToRoman(2008)
"   MMVIII
"
function! ToRoman(number) abort
  let roman = repeat('M', a:number / 1000)
    \. repeat('D', a:number % 1000 / 500)
    \. repeat('C', a:number % 500 / 100)
    \. repeat('L', a:number % 100 / 50)
    \. repeat('X', a:number % 50 / 10)
    \. repeat('V', a:number % 10 / 5)
    \. repeat('I', a:number % 5)

  let roman = substitute(roman, 'DCCCC', 'CM', '')
  let roman = substitute(roman, 'CCCC', 'CD', '')
  let roman = substitute(roman, 'LXXXX', 'XC', '')
  let roman = substitute(roman, 'XXXX', 'XL', '')
  let roman = substitute(roman, 'VIIII', 'IX', '')
  let roman = substitute(roman, 'IIII', 'IV', '')

  return roman
endfunction
