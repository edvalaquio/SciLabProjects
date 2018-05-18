
function mid = midpoint(a, b, n, h, ft)
	for i = a:h:(b-h)
		result = result + func(i + (h/2), ft)
	end
	mid = h * result
endfunction
 
function trap = trapezoid(a, b, n, h, ft)
	for i = a:h:(b-h)
		result = result + (func(i, ft) + func(i + h, ft))
	end
	trap = (h/2) * result
endfunction
 
function simp = simpson(a, b, n, h, ft)
	for i = a:(2*h):(b-h)
		result = result + (func(i, ft) + (4*func(i + h, ft)) + func(i + (2 * h), ft))
	end
	simp = (h/3) * result
endfunction

function h = computeH(a, b, n)
	h = (b - a) / n
endfunction

function area = getArea(a, b, n, areaType, ft)
	h = computeH(a, b, n)
	result = 0
	if areaType == 'midpoint' then
		area = midpoint(a, b, n, h, ft)
	elseif areaType == 'trapezoid' then
		area = trapezoid(a, b, n, h, ft)
	elseif areaType == 'simpson' then
		area = simpson(a, b, n, h, ft)
	else
		area = 'Invalid areaType'
	end
endfunction