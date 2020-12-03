"
" Clean up user-entered phone numbers so that they can be sent SMS messages.
"
" Example:
"
"   :echo ToNANP('+1 (613)-995-0253')
"   6139950253
"
function! ToNANP(number) abort
  let digits = str2list(substitute(a:number, '[^0-9]', '', 'g'))

  if len(digits) == 11 && digits[0] == 49
    call remove(digits, 0)
  endif

  if len(digits) != 10 || digits[0] < 50 || digits[3] < 50
    return ''
  else
    return list2str(digits)
endfunction
