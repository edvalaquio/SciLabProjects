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
disp(xValues);
actualY = []
actualY = integral(xValues)


plot2d(xValues, actualY, 1)
plot2d(xValues, eulerMethod(xInput, yInput), 2)
plot2d(xValues, modEulerMethod(xInput, yInput), -3)
plot2d(xValues, midPointMethod(xInput, yInput), -4)
plot2d(xValues, rungeKutta(xInput, yInput), -5)

clear
