%load('../../data/multi-subject/mult_subjects_explicit');

% per subject, only consider connections that appear in at least a fraction
% of 'perm_treshold' of all permutations.
perm_treshold = 0.90;
% in total, only consider connections that appear in at least a fraction
% of 'subj_treshold' of all subjects.
subj_treshold = 0.7;

Gs_avg = squeeze(mean(mean(Gs, 4), 1));

% make a filter by applying these tresholds
filter = squeeze(mean(mean(Gs, 4) > perm_treshold) > subj_treshold);
filter_per_subject = mean(Gs,4) > perm_treshold;

% just take the avarage of all permutations and subjects and filter this
PDAG_avg_filtered = ((squeeze(mean(mean(PDAGs, 4),1)) - ones(116,116)) ./ Gs_avg) .* filter;
PDAG_per_subject_filtered = (mean(PDAGs, 4) - ones(77,116,116)).* filter_per_subject;
PDAG_assymetric_per_subject = PDAG_per_subject_filtered - permute(PDAG_per_subject_filtered, [1,3,2]);
%handle = implay(permute(PDAG_assymetric_per_subject, [2,3,1]), 3); % transpose the last dimensions
%handle.Visual.ColorMap.MapExpression = 'colormap_asymmetric';
% draw things

figure; imagesc(PDAG_avg_filtered);
colormap ('colormap_filtered');
axis square;
%figure; imagesc((PDAG_avg_filtered - PDAG_avg_filtered')); colormap (colormap_asymmetric); axis square;
