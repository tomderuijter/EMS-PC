function [nr] = countSepsets(sepset)
nr = 0;
for i = 1:length(sepset)
	for j = 1:length(sepset)
		if sepset{i,j}~=-1
			nr = nr+1;
	end
end
end