function [bool] = ismember_cell(A,C)
% For a given cell of arrays, determines for each element a in A whether
% a is in any array in S.

	if(iscell(C))
		bool = arrayfun(@(a)any(cellfun(@(var)ismember(a,var), C)), A);	
	else
		bool = ismember(A,C);
	end

end