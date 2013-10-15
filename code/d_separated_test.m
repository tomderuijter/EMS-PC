function [separated] = d_separated_test(x,y,S)

switch length(S)
	
	case 0
		separated = 0;
		return;
	case 1
		separated = isequal(S,2) && ((x==1 && y==3) || (x==1 && y==4) || (x==1 && y==5) || (x==3 && y==4));
		return;
	case 2
		separated = (x==2 && y==5 && isequal(S,[3,4]));
		return;
	case 3
		separated = 0;
		return;
	case 4
		separated = 'dingen gaan mis!';
		return;
end

end