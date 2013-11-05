function [separated] = d_separated2_test(x,y,S)

switch length(S)
	
	case 0
		separated = x == 1 && y == 2;
		return;
	case 1
		if (isequal(S,3))
			separated = (x == 2 && (y == 4 || y == 5)) || (x == 1 && y == 4);
		elseif (isequal(S, 4))
			separated = (x == 2 && y == 5);
		else
			separated = 0;
		end
		return;
	case 2
		separated = isequal(S,[1,4]) && x == 3 && y == 5;
		return;
	case 3
		separated = 0;
		return;
	case 4
		separated = 'dingen gaan mis!';
		return
end

end