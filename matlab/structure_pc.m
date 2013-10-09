function [undirected_graph, sep_sets] = structure_pc(timeseries_data)

% Variable translation
% T - number of samples
% N - number of vertices
% i - iteration number / set cardinality

T = size(data,1);
N = size(data,2);

% Complete undirected graph
undirected_graph = ones(N,N) - eye(N);
sepset = cell(N,N);

i = 0;

% TODO: Move neighbour select outside inner loop

kill_loop = 0;
while(~kill_loop)
   
    % Loop over adjacent vertices
    for x = 1:N
        
        adjacent = undirected_graph(x,:);
        adjacent(adjacent==0) = [];
                
        for y = (x+1):N
            % Matrix is symmetrical
            if(adjacent(x,y))
                % initial set to look at
                subset_indices = (x+1):(x+1+i);
                
                
                while (1) % until all subsets are checked 
                    index_to_raise = i;
                    nextMax = N;
                    while(subset_indices(index_to_raise) == nextMax)
                        index_to_raise = index_to_raise - 1;
                        nextMax = nextMax - 1;
                    end
                    nextMin = subset_indices(index_to_raise);
                    if nextMax < nextMin
                        break;
                    
                    while(index_to_raise <= i)
                        nextMin = nextMin + 1;
                        subset_indices(index_to_raise) = nextMin; % the right value?
                        index_to_raise = index_to_raise + 1;
                    end
                    
                    %doe nu je ding met de subset_indices
                end
                % Loop over subsets of size i
                %subset_indices = [x:(y-1),(y+1):N];
                
                
                
                
                %   If d-seperate(x,y,S)
                %       sep_sets{x,y} = S;
                %       sep_sets{y,x} = sep_sets{x,y};
                %       break;
            end
        end
    end
    i = i+1;
    
    % TODO: Release loop invariant
    if(0)
        kill_loop = 1;
    end
    
end

end

% Graph coding
% 0 - not connected
% 1 - neighbour
% 2 - arrow
% 3 - dot