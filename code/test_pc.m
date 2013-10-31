load('../data/asia');
data = data'; %N rows - NbVar columns
N = size(data,2); %NbVars
cond_indep = 'cond_indep_chisquare';
test = 'pearson';

[G_asia,sepset_asia] = structure_pc(cond_indep,N,data,test);
PDAG_asia = directional_pc(G_asia, sepset_asia);