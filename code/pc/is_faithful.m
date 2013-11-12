% return true if the unshielded triple <x,y,z> is faithful (if sepsets is
% not a cell, this functions works, i.e. it returns true)
function [faithful] = is_faithful(x, y, z, sepsets)
	% check whether there are multiple sepsets, otherwise it is always 
	sets = sepsets{x,z};
	if length(sets) > 1
		% determine the result in the first sepset
		inSepsets = ismember_cell(y, sets(1));
		% check whether all sepsets give the same result as the first
		for n = 2 : length(sets)                            
			if ismember_cell(y, sets(n)) ~= inSepsets
				faithful = false;
				return;
			end
		end
	end
	faithful = true;
end