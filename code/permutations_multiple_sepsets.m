load('../data/data.mat');
subjectNr = 1;
alpha = 0.01;
T = size(Xs,2); % Number of data points
N = size(Xs,3); % Number of variables
data = reshape(Xs(subjectNr,:,:),T,N);
C = cov(data);
nr_perms = 2;

G = zeros(N,N);
PDAG = zeros(N,N);

G_sum_ms = zeros(N,N);
PDAG_sum_ms = zeros(N,N);

start_time = cputime;
for it = 1:nr_perms
	fprintf('\t * Iteration %i\n',it);
	perm = randperm(N);
	C_perm = C(perm,perm);

	fprintf('Calculating structure...\n');
	cond_indep = 'cond_indep_fisher_z';
	tmp=cputime;
	[G_perm,sepset_perm] = structure_pc_multiple_sepsets(cond_indep,N,C_perm,T,alpha);
	tmp=cputime-tmp;
	fprintf('\t- Execution time : %3.2f seconds\n',tmp);
	G(perm,perm) = G_perm;
	G_sum_ms = G_sum_ms + G;
	
	% fprintf('Calculating seperating set given structure...\n');
	% cond_indep = 'cond_indep_fisher_z';
	% tmp=cputime;
	% [sepset2] = sepset_pc(cond_indep,N,structure,C_perm,T); 
	% tmp=cputime-tmp;
	% fprintf('\t- Execution time : %3.2f seconds\n',tmp);

	tmp=cputime;
	fprintf('Finding causal directions...\n');
	PDAG_perm = directional_pc_multiple_sepsets(G_perm,sepset_perm);
	fprintf('Done directing arrows.\n');
	tmp=cputime-tmp;
	fprintf('\t- Execution time : %3.2f seconds\n',tmp);

	PDAG(perm,perm) = PDAG_perm;
	PDAG_sum_ms = PDAG_sum_ms + PDAG;
end
fprintf('\t- Finished iteration.\n\t- Total execution time : %3.2f seconds\n', cputime-start_time);
save('../data/perms.mat');