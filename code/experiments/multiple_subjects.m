function [PDAGs,Gs,Cs] = multiple_subjects(nr_perms, nr_subjects, T, explicit, mult_sepsets, alpha, filename)
% for nr_subjects and T: give a negative number to take all subjects/data

load('../../data/AAL_FuncData.mat');

if (T <= 0 || T > size(FuncData{1},2))
	T = size(FuncData{1},2); % Number of data points
end

% Dataset reduction
FuncData = cellfun(@(x)x(:,1:T), FuncData, 'UniformOutput', false);

if (nr_subjects <= 0 || nr_subjects > length(FuncData))
	nr_subjects = length(FuncData);
end

N = size(FuncData{1},1); % Number of variables

Cs = zeros(nr_subjects, N, N);
Gs = zeros(nr_subjects,N,N,nr_perms);
PDAGs = zeros(nr_subjects, N,N,nr_perms);

fprintf('applying zscore and calculating covariance...\n');
for subject_nr = 1:nr_subjects
	FuncData{subject_nr} = zscore(transpose(FuncData{subject_nr}));
	C = cov(FuncData{subject_nr});
	Cs(subject_nr,:,:) = C;
end

start_time = cputime;
for it = 1:nr_perms
	
	G = zeros(N, N);
	PDAG = zeros(N, N);
	
	for subject_nr = 1:nr_subjects
		fprintf('\t * Iteration %i, subject %i *\n',it, subject_nr);
		perm = randperm(N);
		C_temp = reshape(Cs(subject_nr,:,:),N,N);
		C_perm = C_temp(perm, perm);

		fprintf('Calculating structure...\n');
		tmp=cputime;
		cond_indep = 'cond_indep_fisher_z';
		
		if mult_sepsets == 1
			[G_perm,sepset_perm] = structure_pc_multiple_sepsets(cond_indep,N,C_perm,T,alpha);
		else
			[G_perm,sepset_perm] = structure_pc(cond_indep,N,C_perm,T,alpha);
		end	
		
		tmp=cputime-tmp;
		fprintf('\t- Execution time : %3.2f seconds\n',tmp);
		G(perm,perm) = G_perm;
		Gs(subject_nr,:,:,it) = G;

		tmp=cputime;
		fprintf('Finding causal directions...\n');
		modified = 1;
		PDAG_perm = step2_pc(G_perm, sepset_perm, modified, explicit, 'cond_indep_fisher_z',C,T,alpha);	
		fprintf('Done directing arrows.\n');
		tmp=cputime-tmp;
		fprintf('\t- Execution time : %3.2f seconds\n',tmp);

		PDAG(perm,perm) = PDAG_perm;
		PDAGs(subject_nr,:,:,it) = PDAG;
	end
end

fprintf('finished calculations, saving...');
save(strcat('../../data/', filename, '.mat'), 'PDAGs', 'Gs', 'Cs');
fprintf('\t- Finished iteration.\n\t- Total execution time : %3.2f seconds\n', cputime-start_time);

end