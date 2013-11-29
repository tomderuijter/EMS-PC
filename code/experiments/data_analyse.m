GsMean = mean(Gs,4);
GsMean = permute(GsMean,[2,3,1]);

PDAGsMean = mean(PDAGs,4);
PDAGsMean = permute(PDAGsMean,[2,3,1]);

PDAGsNorm = zeros(116,116,77);
for n = 1:77
    PDAGsNorm(:,:,n) = PDAGsMean(:,:,n) ./ GsMean(:,:,n);
end