function [directed_graph] = directional_modified_pc(undirected_graph, sepset)

    modified = 1;
    explicit = 0;
    varargin = cell(0);
    directed_graph = step2_pc(undirected_graph, sepset, modified, explicit, varargin{:});

end