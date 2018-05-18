function bool = getBool(e) 
	if e then
		bool = "true";
	else
		bool = "false"
	end
endfunction

function fun = func(x, ft)
	if ft == 'polynomial' then
		fun = (x .^ 2) - 2
	elseif ft == 'trigonometric' then
		fun = sin(x)
	elseif ft == 'exponential' then
		fun = 2 .^ x
	else
		fun = 'Invalid input in ft'
	end		
endfunction

function fun = deriv(x, ft)
	if ft == 'polynomial' then
		fun = 2 * x
	elseif ft == 'trigonometric' then
		fun = cos(x)
	elseif ft == 'exponential' then
		fun = log(2) * (2 .^ x)
	else
		fun = 'Invalid input in ft'
	end	
endfunction

function fun = integ(x, ft)
	if ft == 'polynomial' then
		fun = (x .^ 3)/3 - (2 * x)
	elseif ft == 'trigonometric' then
		fun = -(cos(x))
	elseif ft == 'exponential' then
		fun = (2 .^ x)/log(2)
	else
		fun = 'Invalid input in ft'
	end	
endfunction

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