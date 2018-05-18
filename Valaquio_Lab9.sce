function matrix = computeMatrix(mat)
	numRows = size(mat, 1)
	for i = 1:1:numRows
		if(mat(i, i) == 0 & i < numRows) then
			mat([i, i+1], :) = mat([i+1, i], :)
		end
		if(mat(i, i) <> 1) then
			mat(i, :) = mat(i, :)/mat(i, i)
		end
		prevNext = [1:(i-1) (i+1):numRows]
		mat(prevNext, :) = (-mat(prevNext, i))/mat(i, i) * mat(i, :) + mat(prevNext, :)
	end
	matrix = mat
endfunction

function piece = generatePieceWise(a, b, c, d, x, len)
	piece = []
	disp(x);
	disp(a);
	disp(b);
	for i = 1:1:len
		strA = string(a(i))
		strB = string(b(i)) + "(x-" + string(x(i,:)) + ")"
		strC = string(c(i)) + "(x-" + string(x(i,:)) + ")^2"
		strD = string(d(i)) + "(x-" + string(x(i,:)) + ")^3"
		piece(i,:) = strA + " + " + strB + " + " + strC + " + " + strD
	end
endfunction

function free = computeCubicFree(mat, h)
	y(1,:) = mat(:, 2)
	n = size(mat)
	A = []
	v = []

	v(1:n(1)) = zeros()
	A(1:n(1), 1:n(1)) = zeros()
	A(1, 1) = 1
	A($, $) = 1
	
	space = 1
	for i = 2:1:(n(1)-1)

		yTemp = 3 * (((y(i+1) - y(i))/h(i)) - ((y(i) - y(i-1))/h(i-1)))
		v(i) = [yTemp]
		hTemp = 2 * (h(i-1) + h(i))
		temp = [h(i-1) hTemp h(i)]
		for j = 1:1:size(temp, 2)
			A(i, (space+j) - 1) = temp(j)
		end
		space = space + 1
	end

	free = [A v]

endfunction

function clamped = computeCubicClamped(mat, h)

	y(1,:) = mat(:, 2)
	x(1,:) = mat(:, 1)

	alpha = (y(2) - y(1))/(x(2) - x(1))
	beta1 = (y($) - y($-1))/(x($) - x($-1))

	n = size(mat)
	A = []
	v = []

	v(1:n(1)) = zeros()
	yTemp = 3 * (((y(2) - y(1))/h(1)) - alpha)
	v(1) = [yTemp]
	yTemp = 3 * (beta1 - ((y($) - y($-1))/h($)))
	v($) = yTemp

	A(1:n(1), 1:n(1)) = zeros()
	A(1, 1:2) = [(2 * h(1)) h(1)]
	A($, ($-1):$) = [h($) (2 * h($))]

	space = 1
	for i = 2:1:(n(1)-1)
		yTemp = 3 * (((y(i+1) - y(i))/h(i)) - ((y(i) - y(i-1))/h(i-1)))
		v(i) = [yTemp]
		
		hTemp = 2 * (h(i-1) + h(i))
		temp = [h(i-1) hTemp h(i)]
		for j = 1:1:size(temp, 2)
			A(i, (space+j) - 1) = temp(j)
		end
		space = space + 1
	end
	disp(A)
	clamped = [A v]
endfunction

function cubic = computeCubic(mat, isFree)
	Av = []
	h(1,:) = diff(mat(:, 1))
	if(isFree)
		Av = computeCubicFree(mat, h)
	else
		Av = computeCubicClamped(mat, h)
	end

	disp(Av);
	linMat = computeMatrix(Av)
	disp(linMat);

	n = size(mat)
	a(1,:) = mat(:, 2)
	c(1,:) = linMat(:, $)
	b = []
	d = []
	for i = 1:1:n(1)-1
		bTemp = ((a(i+1) - a(i))/h(i)) - (h(i) * ((2 * c(i)) + c(i+1))/3)
		b(1, i) = bTemp

		dTemp = (c(i+1) - c(i))/(3 * h(i))
		d(1, i) = dTemp
	end
	// disp(mat(:, 1))
	cubic = generatePieceWise(a, b, c, d, mat(:,1) ,n(1)-1)

endfunction

// given = [
// 	1 1
// 	3 2
// 	4 3
// 	6 8
// ]
given = [
	1 3
	2 5
	3 8
]
funcprot(0)
disp(computeCubic(given, %F))
clear
