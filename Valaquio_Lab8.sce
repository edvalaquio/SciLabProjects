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

A = [2 -1 1; 1 2 -1; -1 1 2]
b = [-1; 6; -1]
disp([A b])
funcprot(0)
something = computeMatrix([A b])
disp(something(:, $));
disp(A * something(:, $))
clear