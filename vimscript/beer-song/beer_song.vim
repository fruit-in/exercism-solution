"
" Produce the lyrics to that beloved classic, that field-trip favorite: 99
" Bottles of Beer on the Wall.
"
"   :echo Verse(99)
"   99 bottles of beer on the wall, 99 bottles of beer.
"   Take one down and pass it around, 98 bottles of beer on the wall.
"
"
"   :echo Verses(99, 98)
"   99 bottles of beer on the wall, 99 bottles of beer.
"   Take one down and pass it around, 98 bottles of beer on the wall.
"
"   98 bottles of beer on the wall, 98 bottles of beer.
"   Take one down and pass it around, 97 bottles of beer on the wall.
"

function! Bottle(verse) abort
  if a:verse == 0
    return 'No more bottles'
  elseif a:verse == 1
    return '1 bottle'
  else
    return a:verse . ' bottles'
  endif
endfunction

function! Take(verse) abort
  if a:verse == 0
    return 'Go to the store and buy some more'
  elseif a:verse == 1
    return 'Take it down and pass it around'
  else
    return 'Take one down and pass it around'
  endif
endfunction

function! Verse(verse) abort
  return Bottle(a:verse) . ' of beer on the wall, '
    \. tolower(Bottle(a:verse)) . " of beer.\n"
    \. Take(a:verse) . ', '
    \. tolower(Bottle((a:verse + 99) % 100)) . " of beer on the wall.\n"
endfunction

function! Verses(start, end) abort
  return join(map(reverse(range(a:end, a:start)), 'Verse(v:val)'), "\n")
endfunction
