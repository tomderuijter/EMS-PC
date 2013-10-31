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

perm = 1:N;
%perm = randperm(N);
%perm = [1:2:90 2:2:90 91:116]; % Left and right hemisphere separation.
C_perm = C(perm,perm);


% == TIME-SERIES == %

% Find adjacency matrix given time-series data.
fprintf('Calculating structure...\n');
cond_indep = 'cond_indep_fisher_z';
tmp=cputime;
[G_perm,sepset_perm] = structure_pc(cond_indep,N,C_perm,T);
tmp=cputime-tmp;
fprintf('\t- Execution time : %3.2f seconds\n',tmp);


fprintf('Finding causal directions...\n');
tmp=cputime;
PDAG_perm = directional_pc(G_perm,sepset_perm);
tmp=cputime-tmp;
fprintf('Done directing arrows.\n');
fprintf('\t- Execution time : %3.2f seconds\n',tmp);

G(perm,perm) = G_perm;
PDAG(perm,perm) = PDAG_perm;


% == STRUCTURE == %

% structure_perm = structure(perm,perm);
% 
% % Find seperating set given structure.
% fprintf('Calculating seperating set given structure...\n');
% cond_indep = 'cond_indep_fisher_z';
% tmp=cputime;
% [sepset2_perm] = sepset_pc(cond_indep,N,structure_perm,C_perm,T); 
% tmp=cputime-tmp;
% fprintf('\t- Execution time : %3.2f seconds\n',tmp);
% 
%
% fprintf('Finding causal directions...\n');
% tmp=cputime;
% PDAG2_perm = directional_pc(structure_perm,sepset2_perm);
% tmp=cputime-tmp;
% fprintf('Done directing arrows.\n');
% fprintf('\t- Execution time : %3.2f seconds\n',tmp);
% 
% PDAG2(perm,perm) = PDAG2_perm;