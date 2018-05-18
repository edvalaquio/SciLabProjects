curDir = get_absolute_file_path('Valaquio_MP2.sce')
getd(curDir + '/functions')

//============================= Number 1
function item = number1()

	num = [100.0 154.2349 -12.32157 -(2/3)]
	for i = 1:1:size(num, 2)
		disp('==========================');
		printf("Input: %f\n\n", num(i))
		printf("Double Precision: \n")
		bin = getNumberFormat(num(i), %T)
		dec = getNumberFormat(bin, %T)
		printf("Binary: %s \n", bin)
		printf("Decimal: %f \n", dec)
		printf("Equality: %s \n\n", getBool(num(i)==dec))

		printf("Single Precision: \n")
		bin = getNumberFormat(num(i), %F)
		dec = getNumberFormat(bin, %F)
		printf("Binary: %s \n", bin)
		printf("Decimal: %f \n", dec)
		printf("Equality: %s \n", getBool(num(i)==dec))

		disp('==========================');
	end
	item = ''
endfunction

//============================= Number 2
function item = number2()
	// funcType = ["polynomial" "trigonometric" "exponential"]
	// funcType = "polynomial"
	funcType = "trigonometric"
	// funcType = "exponential"
	// rootType = "bisection"
	// rootType = "newton"
	// rootType = "secant"
	rootType = ["bisection" "newton" "secant"]
	for i = 1:1:size(rootType, 2)
		disp('==========================');
		disp(rootType(i));
		item = getRoot(1, 4, rootType(i), 100, funcType)
		printf("\n\nResult: %f", item)
		disp('==========================');
	end
	// disp()
	item = ''
endfunction

//============================= Number 3
function item = number3()
	a = 0
	b = 4
	n = 4
	aType = ["midpoint", "trapezoid", "simpson"]
	// funcType = "polynomial"
	// funcType = "trigonometric"
	funcType = "exponential"
	disp('==========================');
	actual = integ(b, funcType) - integ(a, funcType)
	printf("Actual: %f", actual)
	disp('==========================');
	for i = 1:1:size(aType, 2)
		disp('==========================');
		temp = getArea(a, b, n, aType(i), funcType)
		printf("%s: %f\n", aType(i), temp)

		percentage = (abs(actual - temp))/actual * 100
		printf("Percentage difference: %f ", percentage);
		disp('==========================');
	end
	item = ''
endfunction

//============================= Number 4
function item = number4()

	h1 = 0.5
	n1 = 4
	x1 = 0
	y1 = 0
	// funcType = 'polynomial'
	funcType = 'trigonometric'
	// funcType = 'exponential'
	rt = ['actual' 'modEulerMethod' 'midPointMethod' 'fourthOrder' ]
	// i = 4
	// result = getRungeKutta(x1, y1, h1, n1, rt(1, i), funcType)
	// plot2d(result(1, :), result(2, :), i)
	for i = 1:1:size(rt, 2)
		result = getRungeKutta(x1, y1, h1, n1, rt(1, i), funcType)
		disp(rt(i));
		disp(result(2,:));
		plot2d(result(1, :), result(2, :), i)
	end
	// result = getRungeKutta(x1, y1, h1, n1, 'actual', funcType)
	// plot2d(result(1, :), result(2, :), 1)
	item = ''
endfunction

//============================= Number 5
function item = number5()


	// given = [
	// 	1 1
	// 	3 2
	// 	4 3
	// 	6 8
	// ]
	// given = [
	// 	1 3
	// 	2 5
	// 	3 8
	// ]
	given = [
		1 func(1, 'polynomial')
		2 func(2, 'polynomial')
		3 func(3, 'polynomial')
	]
	result = interpolation(2, given, 'spline', %T)
	disp(result);
	item = ''
endfunction

// disp('Time:');
// disp(timer())
number = 5
select number
	case 1 then
		number1()
	case 2 then
		number2()
	case 3 then
		number3()
	case 4 then
		number4()
	case 5 then
		number5()
			
end


clear