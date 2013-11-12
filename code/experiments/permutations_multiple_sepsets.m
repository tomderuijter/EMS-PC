load('../data/data.mat');
addpath('../pc');
addpath('../independence');

subjectNr = 1;
alpha = 0.005;
T = size(Xs,2); % Number of data points
N = size(Xs,3); % Number of variables
data = reshape(Xs(subjectNr,:,:),T,N);
C = cov(data);
nr_perms = 1000;

G = zeros(N,N);
PDAG = zeros(N,N);

Gs = zeros(N,N,nr_perms);
PDAGs = zeros(N,N,nr_perms);

start_time = cputime;
for it = 1:nr_perms
	fprintf('\t * Iteration %i\n',it);
	perm = randperm(N);
	C_perm = C(perm,perm);

    % Calculate structure
	fprintf('Calculating structure...\n');
	cond_indep = 'cond_indep_fisher_z';
	tmp=cputime;
	[G_perm,sepset_perm] = structure_pc_multiple_sepsets(cond_indep,N,C_perm,T,alpha);
	tmp=cputime-tmp;
	fprintf('\t- Execution time : %3.2f seconds\n',tmp);
	
    G(perm,perm) = G_perm;
	Gs(:,:,it) = G;
	
    % Find directionality
	tmp=cputime;
	fprintf('Finding causal directions...\n');
	PDAG_perm = directional_modified_pc(G_perm,sepset_perm);
	fprintf('Done directing arrows.\n');
	tmp=cputime-tmp;
	fprintf('\t- Execution time : %3.2f seconds\n',tmp);

	PDAG(perm,perm) = PDAG_perm;
	PDAGs(:,:,it) = PDAG;
end
fprintf('\t- Finished iteration.\n\t- Total execution time : %3.2f seconds\n', cputime-start_time);
save('../data/perms.mat');