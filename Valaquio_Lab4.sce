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
	// tolerance = 1e-15
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
	// form = ((x .^ 2) - 2)
	form = sin(x)
endfunction

function derive = fp(x)
	// derive = (2 * x)
	derive = cos(x)
endfunction


funcprot(0)
disp(newton(1))
// disp(secant(1, 2))
