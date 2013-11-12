function [directed_graph] = explicit_directional_pc(undirected_graph, sepset, varargin)

    modified = 1;
    explicit = 1;
    directed_graph = step2_pc(undirected_graph, sepset, modified, explicit, varargin{:});

end