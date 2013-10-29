% Condition C - V structures
% 	i = 0;
% 	for x = 1 : N
% 		right_of_diag = ((x+1) : N);
% 		for y = right_of_diag
% 
% 			% x and y not connected -> not interesting
% 			if ~undirected_graph(x,y)
% 				continue
% 			end
% 
% 			% for all elements of right_of_diag, excluding y
% 			% x_alg etc. are x, y and z as described in the algorithm
% 			for z_alg = right_of_diag(right_of_diag ~= y)
% 				if (undirected_graph(x,z_alg))
% 					x_alg = y;
% 					y_alg = x;
% 				elseif (undirected_graph(y,z_alg))
% 					x_alg = x;
% 					y_alg = y;
% 				else
% 					continue
% 				end
% 
% 				% if y is not in sepset(x,z)
% 				if (~any(sepset{x_alg,z_alg} == y_alg))
% 					directed_graph(x_alg, y_alg) = 2;
% 					directed_graph(z_alg, y_alg) = 2;
% 					i=i+1;
% 				end
% 			end
% 		end
% 	end