"
" This function takes a year and returns 1 if it's a leap year
" and 0 otherwise.
"
function! LeapYear(year) abort
  return a:year % 4 == 0 && a:year % 100 != 0 || a:year % 400 == 0
endfunction
