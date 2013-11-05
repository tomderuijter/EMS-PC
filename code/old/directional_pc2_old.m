function [pdag] = directional_pc2(G, sep)

% Create the minimal pattern,
% i.e., the only directed edges are V structures.
pdag = G;
n = size(pdag,1);

fprintf('Finding V-structures...\n');
dtime=cputime;
nrEdges=0;
[X, Y] = find(G);
% We want to generate all unique triples x,y,z
% This code generates x,y,z and z,y,x.
for i=1:length(X)
    x = X(i);
    y = Y(i);
    Z = find(G(y,:));
    Z = mysetdiff(Z, x);
    for z=Z(:)'
        if G(x,z)==0 & ~ismember(y, sep{x,z}) & ~ismember(y, sep{z,x})
            %fprintf('%d -> %d <- %d\n', x, y, z);
            pdag(x,y) = 2; pdag(y,x) = 0;
            pdag(z,y) = 2; pdag(y,z) = 0;
            nrEdges=nrEdges+2;
        end
    end
end
fprintf('Done finding V-structures: %d structures found.\n', nrEdges);
dtime = cputime - dtime;
fprintf('\t- Execution time : %3.2f seconds\n',dtime);

fprintf('Completing directional structure...\n');
dtime=cputime;
% Convert the minimal pattern to a complete one,
% i.e., every directed edge in P is compelled
% (must be directed in all Markov equivalent models),
% and every undirected edge in P is reversible.
% We use the rules of Pearl (2000) p51 (derived in Meek (1995))
old_pdag = zeros(n);
iter = 0;
while ~isequal(pdag, old_pdag)
    iter = iter + 1;
    old_pdag = pdag;
 
    % rule 1
    [A,B] = find(pdag==2); % a -> b
    for i=1:length(A)
        a = A(i); b = B(i);
        C = find(pdag(b,:)==1 & G(a,:)==0); % all nodes adj to b but not a
        if ~isempty(C)
            pdag(b,C) = 2; pdag(C,b) = 0;
            %fprintf('rule 1: a=%d->b=%d and b=%d-c=%d implies %d->%d\n', a, b, b, C, b, C);
            nrEdges=nrEdges+1;
        end
    end
     
    % rule 2 - directed paths of length 1
	[A,B] = find(pdag==1); % unoriented a-b edge
    for i=1:length(A)
        a = A(i); b = B(i);
        if any( (pdag(a,:)==-1) & (pdag(:,b)==-1)' ); % Node C s.t. a->C->b
            pdag(a,b) = 2; pdag(b,a) = 0;
            %fprintf('rule 2: %d -> %d\n', a, b);
            nrEdges=nrEdges+1;
        end
    end
    
    % rule 3
	[A,B] = find(pdag==1); % a-b
	for i=1:length(A)
        a = A(i); b = B(i);
        C = find( (pdag(a,:)==1) & (pdag(:,b)==2)' );
   
        % C contains nodes c s.t. a-c->ba
        G2 = setdiag(G(C, C), 1);
        if any(G2(:)==0) % there are 2 different non adjacent elements of C
            pdag(a,b) = -1; pdag(b,a) = 0;
            %fprintf('rule 3: %d -> %d\n', a, b);
            nrEdges=nrEdges+1;
        end
	end
end

dtime = cputime - dtime;
fprintf('\t- Execution time : %3.2f seconds\n',dtime);
fprintf('Done finding additional edges: %d directional edges found.\n', nrEdges);

end