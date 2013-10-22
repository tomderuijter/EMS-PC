% Data max
load('../data/data.mat');
subjectNr = 1;
T = size(Xs,2); % Number of data points
N = size(Xs,3); % Number of variables
data = reshape(Xs(subjectNr,:,:),T,N);
fprintf('Done loading data.\n');
C = cov(data);
fprintf('Done calculating covariance.\n');

cond_indep = 'cond_indep_fisher_z';
[G,sepset] = structure_pc(cond_indep,N,C,T);
fprintf('Done finding structure.\n');
PDAG = directional_pc(G,sepset);
fprintf('Done directing arrows.\n');