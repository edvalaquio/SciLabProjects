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

function m = getSlope(x, y, n)
	m = []
	for i = 1:1:n(1)-1
		m(i,:) = (y(i+1) - y(i))/(x(i+1) - x(i))
	end
endfunction

function van = vandermonde(x, y, n)
	// n = size(mat), x = mat(:, 1), y = mat(:, 2)
    A = zeros(n(1), n(1))
    for i = 1:1:n(1)
        for j = 1:1:n(1)
            A(i, j) = x(i)^(n(1)-j)
        end
    end

    van = computeMatrix([A,y])
endfunction

function piece = piecewise(mat)
	piece = []
	n = size(mat)
	x = mat(:,1), y = mat(:,2)
	m = getSlope(x, y, n)

endfunction

function piece = generatePieceWise(a, b, c, d, x, len)
	piece = []
	for i = 1:1:len
		strA = string(a(i))
		strB = string(b(i)) + "(x-" + string(x(i,:)) + ")"
		strC = string(c(i)) + "(x-" + string(x(i,:)) + ")^2"
		strD = string(d(i)) + "(x-" + string(x(i,:)) + ")^3"
		piece(i,:) = strA + " + " + strB + " + " + strC + " + " + strD
	end
endfunction

function v = getClampedV(x, y, v)
	alpha = (y(2) - y(1))/(x(2) - x(1))
	beta1 = (y($) - y($-1))/(x($) - x($-1))
	yTemp = 3 * (((y(2) - y(1))/h(1)) - alpha)
	v(1) = [yTemp]
	yTemp = 3 * (beta1 - ((y($) - y($-1))/h($)))
	v($) = yTemp
endfunction

function av = getSplineAV(x, y, h, n, isFree)
	A = []
	v(1:n(1)) = zeros()
	A(1:n(1), 1:n(1)) = zeros()
	if isFree then
		A(1, 1) = 1
		A($, $) = 1
	else
		v = getClampedV(x, y, v)
		A(1, 1:2) = [(2 * h(1)) h(1)]
		A($, ($-1):$) = [h($) (2 * h($))]
	end
	av = [A v]
endfunction

function lm = getSplineLinMat(Av)
	
	A = Av(:, 1:$-1), v = Av(:, $)

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

	lm = computeMatrix([A v])

endfunction

function cubic = spline(x, y, n, isFree)
	// x(1,:) = mat(:, 1)
	// y(1,:) = mat(:, 2)
	// n = size(mat)

	h(1,:) = diff(mat(:, 1))
	temp = getSplineAV(x, y, h, n, isFree)
	linMat = getSplineLinMat(temp)
	disp(linMat);

	a(1,:) = mat(:, 2), c(1,:) = linMat(:, $)
	b = [], d = []
	for i = 1:1:n(1)-1
		bTemp = ((a(i+1) - a(i))/h(i)) - (h(i) * ((2 * c(i)) + c(i+1))/3)
		b(1, i) = bTemp

		dTemp = (c(i+1) - c(i))/(3 * h(i))
		d(1, i) = dTemp
	end
	cubic = generatePieceWise(a, b, c, d, mat(:,1), n(1)-1)

endfunction

function int = interpolation(mat, interType, isFree)
	x = mat(:, 1)
	y = mat(:, 2)
	n = size(mat)

	if interType == 'vandermonde' then
		int = vandermonde(x, y, n)
	elseif interType == 'spline' then
		int = spline(x, y, n, isFree)
	elseif interType == 'piecewise'
		int = piecewise(x, y, n, isFree)
	else
		int = "Invalid input"
	end

endfunction

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
// funcprot(0)
// disp(interpolation(given, 'vandermonde', ''))
// clear
