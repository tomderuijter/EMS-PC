function [directed_graph,faith_graph] = explicit_directional_pc(undirected_graph, sepset, varargin)

    modified = 1;
    explicit = 1;
    % varargin: for fisher_z_independence test ('cond_indep_fisher_z',C,T,alpha)
    [directed_graph,faith_graph] = step2_pc(undirected_graph, sepset, modified, explicit, varargin{:});

end