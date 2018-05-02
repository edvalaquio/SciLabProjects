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

function converted = double_precision(number)

	if(type(number) <> 10) then
		s = 0
		if(number < 0) then
			s = 1
		end
		number = abs(number)
		p = floor(log2(number))
		e = p + 1023
		f = (number/(2^p)) - 1

		bin_s = dec2bin(s)
		bin_e = dec2bin(e)
		if(length(bin_e) < 11) then
			tempRange = 11 - length(bin_e)
			for i = 1:1:tempRange
				bin_e = "0" + bin_e
			end
		end
		bin_f = idec2bin(f, 52)

		converted = bin_s + bin_e + bin_f
		disp(size(converted));
	else
		// converted = number
		number = strsplit(number)
		disp(size(number));
		dig_s = number(1)
		dig_e = conVecToStr(number(2:12))
		dig_f = conVecToStr(number(13:64))

		dig_s = bin2dec(dig_s)
		dig_e = bin2dec(dig_e)
		dig_f = ibin2dec(dig_f)


		converted = (-1)^dig_s * (2^(dig_e-1023)) * (1+dig_f)
	end

endfunction

num = 2^-800
answer = double_precision(num)
disp(answer)
disp(double_precision(answer))
