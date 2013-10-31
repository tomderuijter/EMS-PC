% test PC + Chi2 statistical test

clear all;

% Load data
load('../data/data.mat');
subjectNr = 1;
T = size(Xs,2); % Number of data points
N = size(Xs,3); % Number of variables
data = reshape(Xs(subjectNr,:,:),T,N);
structure = reshape(Gs(subjectNr,:,:),N,N);
fprintf('Done loading data.\n');
C = cov(data);
fprintf('Done calculating covariance.\n');

cond_indep = 'cond_indep_fisher_z';
tmp=cputime;
PC.dag = learn_struct_pdag_pc(cond_indep,N,N-2,C,T);
tmp=cputime-tmp;
fprintf('\t- Execution time : %3.2f seconds\n',tmp);

% figure;
% [xx yy] = make_layout(bnet.dag);
% yy=(yy-0.2)*.8/.6+.1;
% xx=(xx-0.2833)*.8/.517+.1;
% subplot(1,3,1), [xx yy]=draw_graph(bnet.dag,names,carre,xx,yy); %,carre);
% title('ASIA original graph');
% subplot(1,3,2), draw_graph(abs(PC.dag),names,carre,xx,yy); %,carre);
% title('PC PDAG');
% dag = cpdag_to_dag(abs(PC.dag));
% subplot(1,3,3), draw_graph(dag,names,carre,xx,yy);
% title('PC DAG');
% drawnow;