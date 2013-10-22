function [seperated] = d_seperated2_test(x,y,S)

switch length(S)
	
	case 0
		seperated = x == 1 && y == 2;
		return;
	case 1
		if (isequal(S,3))
			seperated = (x == 2 && (y == 4 || y == 5)) || (x == 1 && y == 4);
		elseif (isequal(S, 4))
			seperated = (x == 2 && y == 5);
		else
			seperated = 0;
		end
		return;
	case 2
		seperated = isequal(S,[1,4]) && x == 3 && y == 5;
		return;
	case 3
		seperated = 0;
		return;
	case 4
		seperated = 'dingen gaan mis!';
		return
end

end