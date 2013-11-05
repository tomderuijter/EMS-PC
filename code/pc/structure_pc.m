function [undirected_graph, sepset] = structure_pc(cond_indep, N, varargin)

% Variable translation
% cond_indep - conditional independence test
% N - number of vertices
% varargin - Variable arguments used for different conditional tests

[undirected_graph,sepset] = step1_pc(cond_indep, N, -1, varargin{:});

end