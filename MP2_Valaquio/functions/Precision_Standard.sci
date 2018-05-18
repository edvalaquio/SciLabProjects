function string = conVecToStr(vector)
	string = ""
	for i = 1:1:size(vector, 1)
		string = string + vector(i, 1)
	end
endfunction

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

function i = idec2bin(inumber,len)
    i = ""
    for bi = 1:len
        inumber = inumber * 2
        f = floor(inumber)
        i = i + string(f)
        inumber = inumber - f
    end
endfunction


function precision = getBinary(number, isDouble)

	number = strsplit(number)
	dig_s = number(1)
	if(isDouble) then
		dig_e = conVecToStr(number(2:12))
		dig_f = conVecToStr(number(13:$))
	else
		dig_e = conVecToStr(number(2:9))
		dig_f = conVecToStr(number(10:$))
	end

	dig_s = bin2dec(dig_s)
	dig_e = bin2dec(dig_e)
	dig_f = ibin2dec(dig_f)

	if(isDouble) then
		dig_e = 2^(dig_e-1023)
	else
		dig_e = 2^(dig_e-127)
	end

	precision = (-1)^dig_s * dig_e * (1+dig_f)

endfunction

function precision = getDecimal(number, isDouble)

		s = 0
		if(number < 0) then
			s = 1
		end
		
		number = abs(number)
		p = floor(log2(number))

		if(isDouble) then
			e = p + 1023
		else
			e = p + 127
		end
		f = (number/(2^p)) - 1

		bin_s = dec2bin(s)
		bin_e = dec2bin(e)
		if(isDouble) then
			if(length(bin_e) < 11) then
				tempRange = 11 - length(bin_e)
				for i = 1:1:tempRange
					bin_e = "0" + bin_e
				end
			end
			bin_f = idec2bin(f, 52)
		else
			if(length(bin_e) < 8) then
				tempRange = 8 - length(bin_e)
				for i = 1:1:tempRange
					bin_e = "0" + bin_e
				end
			end
			bin_f = idec2bin(f, 23)
 		end

		precision = bin_s + bin_e + bin_f
endfunction

function converted = getNumberFormat(number, isDouble)
	if(type(number) <> 10) then
		converted = getDecimal(number, isDouble)
	else
		converted = getBinary(number, isDouble)
	end
endfunction


funcprot(0)
