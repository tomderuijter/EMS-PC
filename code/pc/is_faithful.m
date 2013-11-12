
% return true if the unshielded triple <x,y,z> is faithful (if sepsets is
% not a cell, this functions works, i.e. it returns true)
function [faithful] = is_faithful(x, y, z, sepsets)
	% check whether there are multiple sepsets, otherwise it is always 
	if (isCell(sepsets) && length(sepsets{x,z}) > 1)
		% determine the result in the first sepset
		inSepsets = (ismember(y, sepsets{x,z}(1)));
		% check whether all sepsets give the same result as the first
		for (n = 2 : length(sepsets{x,z}))
			if (ismember(y, sepsets{x,z}(n)) ~= inSepsets)
				faithful = false;
				return;
			end
		end
	end
	faithful = true;
end

% marks the unshielded triple <x,y,z> as unfaithful by adding y to {x,z}
% (yes, this function cannot be called from outside so insert where needed)
function [faithfulness] = set_unfaithful(faithfulness, x, y, z)
	faithfulness{x,y} = [faithfulness{x,y} z];
end