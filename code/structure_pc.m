function [undirected_graph, sepset] = structure_pc(cond_indep, N, varargin)

% STRUCTURE_PC Learns the skeleton structure of a given set of nodes.
% P = structure_pc(cond_indep, N, ...)

% Variable translation
% N - number of vertices
% cond_indep - boolean function, called through
% feval(cond_indep,x,y,S,varargs) 
% varargs is a cell array containing optional parameters


% Complete undirected graph
undirected_graph = ones(N,N) - eye(N);
sepset = cell(N,N);

i = 0; % iteration number / set cardinality

% TODO: Move neighbour select outside inner loop

kill_loop = 0;
while(~kill_loop)
    kill_loop = 1;
    
	% Loop over adjacent vertices
    for x = 1:N
		
        % a vector with the indices of neighbours of x (in
        % undirected_graph)
		adjacent_to_x = find(undirected_graph(x,:)); % TODO: Find is slow. Replace.
		
		% cardinality of Adj(C,x)\{y} must be greater than or equal to i
		if length(adjacent_to_x)-1 < i
			continue;
		end
		
		kill_loop = 0;
        for y = adjacent_to_x
			if (y <= x)
				continue;
			end
			index_y_in_adjacent = find(adjacent_to_x == y,1,'first');	
			
			% create initial subset 1,2,.. of length i, excluding y
			if (index_y_in_adjacent <= i)
				subset_indices = [1:(index_y_in_adjacent-1),(index_y_in_adjacent+1):i+1];
			else
				subset_indices = 1:i;
			end
			
			checking_subsets = 1;
			while (checking_subsets) % until all subsets are checked
				S = adjacent_to_x(subset_indices);
				if feval(cond_indep,x,y,S,varargin{:})
					[undirected_graph,sepset] = remove_edge(undirected_graph,x,y,sepset,S);
					checking_subsets = 0;
				else
					[subset_indices, checking_subsets] = subsets(subset_indices, length(adjacent_to_x), index_y_in_adjacent);
				end
			end
        end
    end
    i = i+1;    
end

end

function [G,sepset] = remove_edge(G,x,y,sepset,S)
	G(x,y) = 0;
	G(y,x) = 0;
	sepset{x,y} = S;
	sepset{y,x} = S;
end

% Graph coding
% 0 - not connected
% 1 - neighbour
% 2 - arrow
% 3 - dot
% one of these values at (x,y) means that this code is at node x, on the
% connection to y
