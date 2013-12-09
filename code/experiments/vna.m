function vna(filename, A, pos, labels)

%load('../../data/pos.mat');
%labels = fopen('../../data/AALlabels.txt');

n = length(A);

fid = fopen(filename, 'w');

fprintf(fid, '*node data\n');
fprintf(fid, 'id x y z name\n');

for i=1:n
     fprintf(fid, '%d %d %d %d %s\n', i, round(pos(i,:)), labels{i}); 
end

fprintf(fid, '*tie data\n');
fprintf(fid, 'source target weight\n');

[S, T, w] = find(A);

fprintf(fid, '%d %d %f\n', [S T w]');

fclose(fid);

