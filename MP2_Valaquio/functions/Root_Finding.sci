function tol = checkTolerance(result)
	tolerance = (1e-15)
	tol = abs(result) < tolerance
endfunction

function bi = bisection(x0, x1, coord, maxIteration, ft)
	midx = 0
	for count = 1:1:maxIteration
		midx = (x0 + x1)/2
		result = func(midx, ft)
		plot2d(midx, func(midx, ft), -1)
		if (result < 0) then
			x0 = midx
		else
		 	x1 = midx
		end
		if (checkTolerance(result))
			break
		end
	end
	printf("Iterations: %i", count)
	bi = midx
endfunction

function newt = newton(x0, coord, maxIteration, ft)
	result = 0
	for count = 1:1:maxIteration

		result = x0 - (func(x0, ft) / deriv(x0, ft))
		if (checkTolerance(func(result, ft))) then
			break
		end
		x0 = result
		plot2d(x0, func(x0, ft), -1)

	end
	printf("Iterations: %i", count)
	newt = result

endfunction

function sec = secant(x0, x1, coord, maxIteration, ft)
	result = x1
	for count = 1:1:maxIteration
		numerator = (func(x1, ft) * (x1 - x0))
		denominator = (func(x1, ft) - func(x0, ft))
		if (checkTolerance(func(result, ft)) | (denominator == 0)) then
			// disp(count)
			break
		end
		result = (x1 - (numerator/denominator))

		x0 = x1
		x1 = result
		plot2d(result, func(result, ft), -1)
	end
	printf("Iterations: %i", count)
	sec = result
endfunction

function root = getRoot(x0, x1, finder, maxIteration, ft)
	coord = x0:0.1:x1

	plot2d(coord, func(coord, ft), 1)

	plot2d(x0, func(x0, ft), -1)
	if finder == 'newton' then
		root = newton(x0, coord, maxIteration, ft)
	elseif finder == 'bisection' then
		plot2d(x1, func(x1, ft), -1)
		root = bisection(x0, x1, coord, maxIteration, ft)
	elseif finder == 'secant' then
		plot2d(x1, func(x1, ft), -1)
		root = secant(x0, x1, coord, maxIteration, ft)
	else
		root = "Invalid input"
	end
		

endfunction