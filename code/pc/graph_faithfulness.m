function [faith_graph, image] = graph_faithfulness(G,sepset,N)

    faith_graph = cell(N,N);
    image = zeros(N,N);
    
    for x = 1 : N
        right_of_diag = ((x+1) : N);
        for y = right_of_diag

            % x and y not connected -> not interesting
            if ~G(x,y)
                continue
            end

            % for all elements ,excluding x and y
            for z_alg = 1:N
                if z_alg == x || z_alg == y
                    continue;
                end

                % Set variables to match algorithm notation
                % x_alg etc. are x, y and z as described in the algorithm
                if (G(x,z_alg) && ~G(y,z_alg))
                    x_alg = y;
                    y_alg = x;
                elseif (G(y,z_alg) && ~G(x,z_alg))
                    x_alg = x;
                    y_alg = y;
                else
                    % No V-structure present
                    continue
                end
                
                % We now have all unshielded triples(X_alg -- Y_alg -- Z_alg
                if ~is_faithful(x_alg,y_alg,z_alg,sepset)
                    faith_graph = set_unfaithful(faith_graph,x_alg,y_alg,z_alg);
                    image(x_alg,z_alg) = 1;
                end

            end
        end
    end

end

% marks the unshielded triple <x,y,z> as unfaithful by adding y to {x,z}
% (yes, this function cannot be called from outside so insert where needed)
function [faithfulness] = set_unfaithful(faithfulness, x, y, z)
	faithfulness{x,y} = [faithfulness{x,y} z];
end