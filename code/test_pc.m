load('../data/asia');
data = data'; %N rows - NbVar columns
N = size(data,2); %NbVars
cond_indep = 'cond_indep_chisquare';
test = 'pearson';

[G,sepset] = structure_pc(cond_indep,N,data,test);