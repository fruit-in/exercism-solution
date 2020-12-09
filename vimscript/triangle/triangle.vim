"
" Determine if a triangle is equilateral, isosceles, or scalene.
"
" An equilateral triangle has all three sides the same length.
"
" An isosceles triangle has at least two sides the same length.
" (It is sometimes specified as having exactly two sides the
" same length, but for the purposes of this exercise we'll say
" at least two.)
"
" A scalene triangle has all sides of different lengths.
"

function! Triangle(triangle) abort
  let triangle = sort(a:triangle)

  return triangle[0] > 0 && triangle[0] + triangle[1] >= triangle[2]
endfunction

function! Equilateral(triangle) abort
  let triangle = sort(a:triangle)

  return Triangle(triangle) && triangle[0] == triangle[2]
endfunction

function! Isosceles(triangle) abort
  let triangle = sort(a:triangle)

  return Triangle(triangle) && (triangle[0] == triangle[1] || triangle[1] == triangle[2])
endfunction

function! Scalene(triangle) abort
  let triangle = sort(a:triangle)

  return Triangle(triangle) && triangle[0] != triangle[1] && triangle[1] != triangle[2]
endfunction

function! Degenerate(triangle) abort
  let triangle = sort(a:triangle)

  return Triangle(triangle) && triangle[0] + triangle[1] == triangle[2]
endfunction
