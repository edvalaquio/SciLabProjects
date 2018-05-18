
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
	// f = (x^3) - 4
	f = (x .^ 2) - 2
endfunction


function integ = integral(x)
	integ = (x .^ 3)/3 - (2 * x)
	// integ = (x^4)/4 - (4 * x)
endfunction

a = 0
b = 4
n = 4
disp(integral(b) - integral(a));
disp(midpoint(0, 4, 4));
disp(trapezoid(0, 4, 4));
disp(simpson(0, 4, 4));
