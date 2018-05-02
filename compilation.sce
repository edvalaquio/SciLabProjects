// =======================================
// LAB 3
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
	else
		number = strsplit(number)
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

// =======================================
// LAB 4
function tol = checkTolerance(result)
	tolerance = (1e-15)
	tol = abs(result) < tolerance
endfunction

function bi = bisection(x0, x1)
	maxIteration = 100
	count = 0
	midx = 0
	coord = 1:0.1:2
	plot2d(coord, f(coord), 1)
	plot2d(x0, f(x0), -1)
	plot2d(x1, f(x1), -1)
	for count = 1:1:maxIteration
		midx = (x0 + x1)/2
		result = f(midx)
		plot2d(midx, f(midx), -1)
		if (result < 0) then
			x0 = midx
		else
		 	x1 = midx
		end
		if (checkTolerance(result))
			break
		end
	end
	bi = midx
endfunction

function newt = newton(x0)
	maxIteration = 100
	result = 0
	coord = 1:0.1:2
	plot2d(coord, f(coord), 1)
	plot2d(x0, f(x0), -1)
	for count = 1:1:maxIteration

		result = x0 - (f(x0) / fp(x0))
		if (checkTolerance(f(result))) then
			break
		end
		x0 = result
		plot2d(x0, f(x0), -1)

	end
	newt = result

endfunction

function sec = secant(x0, x1)
	maxIteration = 100
	coord = 1:0.1:2
	plot2d(coord, f(coord), 1)
	plot2d(x0, f(x0), -1)
	plot2d(x1, f(x1), -1)
	result = x1
	for count = 1:1:maxIteration
		numerator = (f(x1) * (x1 - x0))
		denominator = (f(x1) - f(x0))
		if (checkTolerance(f(result)) | (denominator == 0)) then
			break
		end
		result = (x1 - (numerator/denominator))

		x0 = x1
		x1 = result
		plot2d(result, f(result), -1)
	end
	sec = result
endfunction

function form = f(x)
	form = ((x^2) - 2)
endfunction

function derive = fp(x)
	derive = (2 * x)
endfunction

// =======================================
// LAB 5
function mid = midpoint(a, b, n)
	h = computeH(a, b, n)
	result = 0
	for i = a:h:(b-h)
		result = result + func(i + (h/2))
	end
	mid = h * result
endfunction
 
function trap = trapezoid(a, b, n)
	h = computeH(a, b, n)
	result = 0
	for i = a:h:(b-h)
		result = result + (func(i) + func(i + h))
	end
	trap = (h/2) * result

endfunction
 
function simp = simpson(a, b, n)
	h = computeH(a, b, n)
	result = 0
	for i = a:(2*h):(b-h)
		result = result + (func(i) + (4*func(i+h)) + func(i + (2*h)))
	end
	simp = (h/3) * result
endfunction

function h = computeH(a, b, n)
	h = (b - a) / n
endfunction

function f = func(x)
	f = (x^3) - 4
endfunction

function integ = integral(x)
	integ = (x^4)/4 - (4 * x)
endfunction

// =======================================
// LAB 6
function f = func(x)
	f = (2 * x) + 1
endfunction

function integ = integral(x)
	integ = (x.^2) + x
endfunction

function euler = eulerMethod(x, y)
	yValues = []
	yValues(:,1) = y
	for i = 2:1:size(xValues, 2)
		yValues(:,i) = y + (h * func(x))
		x = xValues(:,i)
		y = yValues(:,i)
	end
	euler = yValues
endfunction

function modEuler = modEulerMethod(x, y)
	yValues = []
	yValues(:,1) = y
	for i = 2:1:size(xValues, 2)
		yValues(:,i) = y + ((h/2) * (func(x) + func(x + h)))
		x = xValues(:,i)
		y = yValues(:,i)
	end
	modEuler = yValues
endfunction

function midPoint = midPointMethod(x, y)
	yValues = []
	yValues(:,1) = y
	for i = 2:1:size(xValues, 2)
		yValues(:,i) = y + (h * func(x + (h/2)))
		x = xValues(:,i)
		y = yValues(:,i)
	end
	midPoint = yValues
endfunction

function order = rungeKutta(x, y)
	yValues = []
	yValues(:,1) = y
	for i = 2:1:size(xValues, 2)

		kValues = [h*func(x) h*func(x + h/2) h*func(x + (h/2)) h*func(x + h)]
		yValues(:,i) = y + ((kValues(1) + kValues(4) +  (2 * (kValues(2) + kValues(3))))/6)
		x = xValues(:,i)
		y = yValues(:,i)
	end
	order = yValues
endfunction

h = 0.5
n = 4
xInput = 0
yInput = 0
xValues = 0:h:(xInput+(n*h))
actualY = []
actualY = integral(xValues)

plot2d(xValues, actualY, 1)
plot2d(xValues, eulerMethod(xInput, yInput), 2)
plot2d(xValues, modEulerMethod(xInput, yInput), -3)
plot2d(xValues, midPointMethod(xInput, yInput), -4)
plot2d(xValues, rungeKutta(xInput, yInput), -5)

clear
