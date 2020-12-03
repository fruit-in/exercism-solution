"
" Given a person's allergy score, determine whether or not they're allergic to
" a given item, and their full list of allergies.
"
"   eggs          1
"   peanuts       2
"   shellfish     4
"   strawberries  8
"   tomatoes      16
"   chocolate     32
"   pollen        64
"   cats          128
"
" Examples:
"
"   :echo AllergicTo(5, 'shellfish')
"   1
"
"   :echo List(5)
"   ['eggs', 'shellfish']
"

function! AllergicTo(score, allergy) abort
  let allergens = {'eggs': 1, 'peanuts': 2, 'shellfish': 4, 'strawberries': 8,
    \'tomatoes': 16, 'chocolate': 32, 'pollen': 64, 'cats': 128,}

  return and(a:score, allergens[a:allergy]) > 0
endfunction

function! List(score) abort
  let allergens = ['eggs', 'peanuts', 'shellfish', 'strawberries',
    \'tomatoes', 'chocolate', 'pollen', 'cats',]

  return filter(allergens, 'AllergicTo(a:score, v:val)')
endfunction
