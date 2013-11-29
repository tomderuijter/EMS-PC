%load('../../data/multi-subject/mult_subjects_explicit');

% per subject, only consider connections that appear in at least a fraction
% of 'perm_treshold' of all permutations.
perm_treshold = 0.90;
% in total, only consider connections that appear in at least a fraction
% of 'subj_treshold' of all subjects.
subj_treshold = 0.7;

GsMean = mean(Gs,4); % Average over permutations
Gs_avg = squeeze(mean(GsMean,1)); % Average over subjects

% make a filter by applying these tresholds
filter_per_subject = GsMean > perm_treshold;
filter = squeeze( mean(filter_per_subject) > subj_treshold );

PDAGsMean = mean(PDAGs,4); % Average over permutations
PDAGs_avg = squeeze(mean(PDAGsMean,1)); % Average over subjects

PDAGsNorm = zeros(77,116,116);
for n = 1:77
    PDAGsNorm(n,:,:) = PDAGsMean(n,:,:) ./ GsMean(n,:,:);
end
PDAGsNormUni = squeeze(mean(PDAGsNorm,1));

figure;
for k = 1:77
    trans = squeeze(PDAGsNorm(k,:,:)) - squeeze(PDAGsNorm(k,:,:))';
    trans(find(isnan(trans))) = 2.2;
    trans(1,1) = -2.2;
    imagesc(trans); colormap(cmap); axis square;
%     imagesc(squeeze(PDAGsNorm(k,:,:))); colormap(cmap); axis square;
    title(sprintf('%d',k));
    colorbar;
    pause;
end



PDAG_avg_filtered = (PDAGs_avg ./ (Gs_avg*2)) .* filter; % All connections present in all subjects AFTER filtering
PDAG_assymetric = PDAG_avg_filtered - PDAG_avg_filtered';

PDAG_per_subject_filtered = (PDAGsMean ./ (GsMean*2)) .* filter_per_subject; % All connections present preserving subjects AFTER filtering
PDAG_assymetric_per_subject = PDAG_per_subject_filtered - permute(PDAG_per_subject_filtered, [1,3,2]); % Assymteric components per subject preserving subjects

perm = 1:116;
% perm = [1:2:90 2:2:90 91:116];
% PLOTTING
figure;
subplot(1,2,1);
title 'STRUCTURE - filtered vs no-filter';
imagesc(Gs_avg(perm,perm)); colormap 'hot'; axis square;
subplot(1,2,2);
imagesc(filter(perm,perm)); colormap 'hot'; axis square;

figure;
title 'PDAG - filtered vs no-filter';
colormap(cmap);
subplot(1,2,1);
imagesc(PDAGs_avg(perm,perm)); axis square;
subplot(1,2,2);
imagesc(PDAG_avg_filtered(perm,perm)); axis square;

figure;
title 'PDAG - filtered assymetry';
imagesc(PDAG_assymetric(perm,perm)); colormap(assym_cm); axis square;

figure;
imagesc(PDAGsNormUni); colormap(cmap); axis square;

handle = implay(permute(PDAGsNorm, [2,3,1]), 3); % transpose the last dimensions
handle.Visual.ColorMap.MapExpression = 'cmap';


% For implay
GsMean = permute(GsMean,[2,3,1]);
figure; implay(GsMean);

PDAGsMean = permute(PDAGsMean,[2,3,1]);

handle = implay(permute(PDAG_assymetric_per_subject, [2,3,1]), 3); % transpose the last dimensions
handle.Visual.ColorMap.MapExpression = 'colormap_asymmetric';