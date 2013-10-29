% Data max
load('../data/data.mat');
subjectNr = 1;
T = size(Xs,2); % Number of data points
N = size(Xs,3); % Number of variables
data = reshape(Xs(subjectNr,:,:),T,N);
structure = reshape(Gs(subjectNr,:,:),N,N);
fprintf('Done loading data.\n');
C = cov(data);
fprintf('Done calculating covariance.\n');

% fprintf('Calculating structure...\n');
% cond_indep = 'cond_indep_fisher_z';
% tmp=cputime;
% [G,sepset] = structure_pc(cond_indep,N,C,T);
% tmp=cputime-tmp;
% fprintf('\t- Execution time : %3.2f seconds\n',tmp);

fprintf('Calculating seperating set given structure...\n');
cond_indep = 'cond_indep_fisher_z';
tmp=cputime;
[sepset2] = sepset_pc(cond_indep,N,structure,C,T);
tmp=cputime-tmp;
fprintf('\t- Execution time : %3.2f seconds\n',tmp);

% fprintf('Finding causal directions...\n');
% PDAG = directional_pc(G,sepset);
% fprintf('Done directing arrows.\n');
% tmp=cputime-tmp;
% fprintf('\t- Execution time : %3.2f seconds\n',tmp);