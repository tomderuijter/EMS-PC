function [undirected_graph, sepset] = step1_pc_multiple_sepsets(cond_indep, N, A, varargin)

% Variable translation
% cond_indep - conditional independence test
% N - number of vertices
% A - provided structure to find sepsets for 
% varargin - Variable arguments used for different conditional tests

% Internal variables
% i - iteration number / set cardinality

% Complete undirected graph
undirected_graph = ones(N,N) - eye(N);
sepset = cell(N,N);
[sepset{:,:}] = deal(-1);
i = 0;
kill_loop = 0;
nrSepsetsFound = 0;
while(~kill_loop)
    kill_loop = 1;
    
	% Loop over adjacent vertices
    for x = 1:N
		
        % a vector with the indices of neighbours of x (in
        % undirected_graph)
		adjacent_to_x = find(undirected_graph(x,:));
		if(A ~= -1)
			adjacent_in_A = find(A(x,:));
			adjacent_to_x = mysetdiff(adjacent_to_x,adjacent_in_A);
		end
		
		% cardinality of Adj(C,x)\{y} must be greater than or equal to i
		if length(adjacent_to_x)-1 < i
			continue;
		end
		
		kill_loop = 0;
        for y = adjacent_to_x

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
				if feval(cond_indep, x, y, S, varargin{:})
					[undirected_graph,sepset] = remove_edge(undirected_graph,x,y,sepset,S);
					nrSepsetsFound = nrSepsetsFound + 1;
					%fprintf('order %d, x = %d, y = %d, nr sepsets found: %d\n', i, x, y, nrSepsetsFound);
				end
				[subset_indices, checking_subsets] = subsets(subset_indices, length(adjacent_to_x), index_y_in_adjacent);
			end
        end
    end
    i = i+1;    
end



end

function [G,sepset] = remove_edge(G,x,y,sepset,S)
	G(x,y) = 0;
	G(y,x) = 0;
	if (~iscell(sepset{x,y}))
		sepset{x,y} = cell(1,1);
		sepset{x,y}{1,1} = S;
	else
		nrSepsets = size(sepset{x,y});
		sepset{x,y}{1, nrSepsets(1,2)+1} = S;
	end
	if (~iscell(sepset{y,x}))
		sepset{y,x} = cell(1,1);
		sepset{y,x}{1,1} = S;
	else
		nrSepsets = size(sepset{y,x});
		sepset{y,x}{1, nrSepsets(1,2)+1} = S;
	end
end

% Graph coding
% 0 - not connected
% 1 - neighbour
% 2 - arrow
% 3 - dot