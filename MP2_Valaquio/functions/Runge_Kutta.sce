
function euler = eulerMethod(x, y, h, xValues, ft)
	for i = 2:1:size(xValues, 2)
		yValues(:,i) = y + (h * func(x, ft))
		x = xValues(:,i)
		y = yValues(:,i)
	end
	euler = yValues

endfunction

function modEuler = modEulerMethod(x, y, h, xValues, ft)
	
	for i = 2:1:size(xValues, 2)
		yValues(:,i) = y + ((h/2) * (func(x, ft) + func(x + h, ft)))
		x = xValues(:,i)
		y = yValues(:,i)
	end
	modEuler = yValues

endfunction

function midPoint = midPointMethod(x, y, h, xValues, ft)
	
	for i = 2:1:size(xValues, 2)
		yValues(:,i) = y + (h * func(x + (h/2), ft))
		x = xValues(:,i)
		y = yValues(:,i)
	end
	midPoint = yValues

endfunction

function fourth = fourthOrder(x, y, h, xValues, ft)

	for i = 2:1:size(xValues, 2)
		kValues = [h*func(x, ft) h*func(x + h/2, ft) h*func(x + (h/2), ft) h*func(x + h, ft)]
		yValues(:,i) = y + ((kValues(1) + kValues(4) +  (2 * (kValues(2) + kValues(3))))/6)
		x = xValues(:,i)
		y = yValues(:,i)
	end
	fourth = yValues

endfunction

function runge = getRungeKutta(x, y, h, n, ruType, ft)
	yValues = []
	yValues(:,1) = y
	xValues = 0:h:(x+(n*h))

	if ruType == "eulerMethod" then
		temp = eulerMethod(x, y, h, xValues, ft)
	elseif ruType == "modEulerMethod" then
		temp = modEulerMethod(x, y, h, xValues, ft)
	elseif ruType == "midPointMethod" then
		temp = midPointMethod(x, y, h, xValues, ft)
	elseif ruType == "fourthOrder" then
		temp = fourthOrder(x, y, h, xValues, ft)
	else
		temp = integ(xValues, ft)
	end

	runge = [
		xValues;
		temp
	]

endfunction
