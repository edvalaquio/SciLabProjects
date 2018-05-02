//converts binary to fraction
//istring is the binary number (string type) to be converted
  //may have decimal point or not at the beginning
function i = ibin2dec(istring)
    to = 1;
    if part(istring,1)=='.' then
      to = 2;
    end
    i = 0;
    for si = length(istring):-1:to
        i = (i+strtod(part(istring,si)))/2
    end
endfunction
