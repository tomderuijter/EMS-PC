% perm = [1:2:90 2:2:90 91:116];
perm = 1:116;

G_avg = mean(Gs,4);
G_avg = G_avg(:,perm,perm);
Struct_avg = squeeze(mean(G_avg,1));
StdDev_avg = squeeze(std(G_avg,1));

PDAG_avg = mean(PDAGs,4);
PDAG_std = std(PDAGs,0,4);
PDAG_avg = PDAG_avg(:,perm,perm);
Subj_avg = squeeze(mean(PDAG_avg,1));
Subj_stddev = squeeze(std(PDAG_avg,1));
antisym_subj_avg = (Subj_avg - Subj_avg');

% STRUCTURE
% Plot full subject mean
figure;
colormap 'gray';
subplot(1,2,1);
imagesc(Struct_avg); title('Complete mean structure'); colorbar; axis square;
subplot(1,2,2);
imagesc(Struct_avg - StdDev_avg); title('Structure-stdev'); colorbar; axis square;

% Plot per subject mean
h = figure; colormap 'gray'; %colormap(cmap);
for i=1:6
    imagesc(squeeze(G_avg(i,:,:)));
    title(sprintf('Structure - Subj %d',i));
    colorbar;
    axis square;
    pause;
end
close(h);

% PDAG
figure;
colormap(cmap);
subplot(2,2,1);
imagesc(Subj_avg); colorbar; axis square; title('Complete mean PDAG');
subplot(2,2,2);
imagesc(antisym_subj_avg); colorbar; axis square; title('Antisymmetric mean PDAG');
subplot(2,2,3);
imagesc(Subj_stddev); colorbar; axis square; title('STD PDAG');
subplot(2,2,4);
imagesc(Subj_avg - Subj_stddev); colorbar; axis square; title('mean-std PDAG');

% Plot per subject mean
h = figure; colormap(cmap);
for i=1:6
    subplot(2,2,1);
    imagesc(squeeze(PDAG_avg(i,:,:)));
    title(sprintf('PDAG - Subj %d',i));
    colorbar;
    axis square;
    subplot(2,2,2);
    imagesc(squeeze(PDAG_avg(i,:,:)) - squeeze(PDAG_avg(i,:,:))');
    title(sprintf('ASSYM PDAG - Subj %d',i));
    colorbar;
    axis square;
    subplot(2,2,3);
    imagesc(squeeze(PDAG_std(i,:,:)));
    title(sprintf('STD PDAG - Subj %d',i));
    colorbar;
    axis square;
    subplot(2,2,4);
    imagesc(squeeze(PDAG_avg(i,:,:)) - squeeze(PDAG_std(i,:,:)));
    title(sprintf('mean - std PDAG - Subj %d',i));
    colorbar;
    axis square;
    pause;
end
close(h);
