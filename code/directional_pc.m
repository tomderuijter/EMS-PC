function [directed_graph] = directional_pc(undirected_graph, sepset)
directed_graph = undirected_graph;
N = size(undirected_graph, 1);
assert(N == size(undirected_graph, 2), 'input graph is not a square matrix');
for x = 1 : N
	right_of_diag = ((x+1) : N);
	for y = right_of_diag
		% x and y not connected -> not interesting
		if ~undirected_graph(x,y)
			continue
		end
		
		% for all elements of right_of_diag, excluding y
		% x_alg etc. are x, y and z as described in the algorithm
		for z_alg = right_of_diag(right_of_diag ~= y)
			if (undirected_graph(x,z_alg))
				
				x_alg = y;
				y_alg = x;
			elseif (undirected_graph(y,z_alg))
			    x_alg = x;
				y_alg = y;
			else
				continue
			end
			% if y is not in sepset(x,z)
			if (~any(sepset{x_alg,z_alg} == y_alg))
				directed_graph(y_alg, x_alg) = 2;
				directed_graph(y_alg, z_alg) = 2;
			end
		end
	end
end

% (x,y) denotes if there is a path from x to y
path_from_to = (directed_graph == 2).';
path_from_to = find_all_paths(double(path_from_to));

% the point x,y to check for both conditions
x = 1;
y = 1;
% used to determine whether a full loop over all elements has been made
% without an update (in that case, the loop can stop)
x_last_update = N;
y_last_update = N;
zz = [x, y];
while (x_last_update ~= x || y_last_update ~= y)
	% for each undirected adjacent pair (x,y)
	if ((directed_graph(y,x) == 1) && (directed_graph(x,y) == 1))
		% whether an arrow x -> y or y -> x has been found
		x_y_directed = 0;
		if (path_from_to(x,y))
			directed_graph(y,x) = 2;
			x_y_directed = 1;
		else
			for (z = 1 : N)
				if (z ~= x && z ~= y && (directed_graph(x,z) == 2))
					directed_graph(x,y) = 2;
					x_y_directed = 1;
					x_last_update = x;
					y_last_update = y;
				end
			end
		end

		if (x_y_directed)
			path_from_to = find_all_paths(path_from_to);

			undirected_paths(x,y) = 0;
			undirected_paths(y,x) = 0;

			

			x_last_update = x;
			y_last_update = y;
		end
	end
	[x,y] = next_point_in_square(x,y,N);
	zz = [x, y];
end

%arrowheads_to_check = directed_graph(directed_graph == 2);
%arrowheads_to_check_next = [];
%arrowheads_already_checked = [];

%while (~isempty(arrowheads_to_check))
	
%	arrowheads_already_checked = arrowheads_already_checked:arrowheads_to_check;
%end

end

function [x, y] = next_point_in_square(x, y, N)
% gives the next point in a square of size N. Returns (x+1,y) if that is in
% the bounds, otherwise skips to next row
if (x < N)
	x = x+1;
else
	x = 1;
	if (y < N)
		y = y+1;
	else
		y = 1;
	end
end
if (x == y)
	[x, y] = next_point_in_square(x, y, N);
end
end

function [path_from_to] = find_all_paths(path_from_to)
next_order = path_from_to*path_from_to;
to_return = path_from_to;
while(any(any(next_order)))
	to_return = to_return + next_order;
	next_order = next_order*path_from_to;
end
path_from_to = to_return;
end
% Graph coding
% 0 - not connected
% 1 - neighbour
% 2 - arrow
% 3 - dot
% one of these values at (x,y) means that this code is at node x, on the
% connection to y. For example, (x,y)=1 and (y,x)=2 means x -> y