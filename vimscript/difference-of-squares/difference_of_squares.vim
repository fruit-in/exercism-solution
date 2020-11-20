"
" Find the difference between the square of the sum and the sum of the squares
" of the first N natural numbers.
"
" Examples:
"
"   :echo SquareOfSum(3)
"   36
"   :echo SumOfSquares(3)
"   14
"   :echo DifferenceOfSquares(3)
"   22
"
function! DifferenceOfSquares(number) abort
  return SquareOfSum(a:number) - SumOfSquares(a:number)
endfunction

function! SquareOfSum(number) abort
  return a:number * a:number * (a:number + 1) * (a:number + 1) / 4
endfunction

function! SumOfSquares(number) abort
  return a:number * (a:number + 1) * (2 * a:number + 1) / 6
endfunction
