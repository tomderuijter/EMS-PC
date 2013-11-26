GsPerm = permute(Gs, [1,4,2,3]);

GsMean = zeros(77,116,116); 
for subjNr = 1: 77
	GsMean(subjNr,:,:) = squeeze(mean(squeeze(GsPerm(subjNr,:,:,:))));
end
GsMean = permute(GsMean, [2,3,1]);