function [sepset] = sepset_pc(cond_indep, N, A, varargin)

% Variable translation
% cond_indep - conditional independence test
% N - number of vertices
% varargin - Variable arguments used for different conditional tests

[~,sepset] = step1_pc(cond_indep, N, A, varargin{:});

end