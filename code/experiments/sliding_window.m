load('../data/data.mat');
subjectNr = 1;
window_start = 1;
window_size = 50;
window_interval = 40;
alpha=0.025;
cond_indep = 'cond_indep_fisher_z';

Ttot = size(Xs,2); % Number of data points
N = size(Xs,3); % Number of variables
datatot = reshape(Xs(subjectNr,:,:),Ttot,N);

start_time = cputime;

G_window = zeros(N, N, 0);
PDAG_window = zeros(N, N, 0);
G_window_avg = zeros(N, N);
PDAG_window_avg = zeros(N, N);

window_number = 0;
while (window_start + window_size < Ttot)
	window_number = window_number + 1;
	
	fprintf('\t * Iteration %i, window from %i to %i\n', window_number, window_start, (window_start + window_size));
	data = datatot(window_start:(window_start+window_size), :);
	C = cov(data);
	
	[G,sepset] = structure_pc_multiple_sepsets(cond_indep,N,C,window_size,alpha);
	G_window(:,:,window_number) = G;
	G_window_avg = G_window_avg + G;
	PDAG = explicit_directional_pc(G, sepset, cond_indep,C,window_size,alpha);
	PDAG_window(:,:,window_number) = PDAG;
	PDAG_window_avg = PDAG_window_avg + PDAG;
	
	window_start = window_start + window_interval;
end
PDAG_window_avg = PDAG_window_avg ./ window_number;
G_window_avg = G_window_avg ./ window_number;

fprintf('\t- Finished sliding windows.\n\t- Total execution time : %3.2f seconds\n', cputime-start_time);

save('../../data/sliding_window.mat', 'G_window', 'PDAG_window', 'G_window_avg', 'PDAG_window_avg');