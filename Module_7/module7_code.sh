#!/bin/bash

# Module 7 code

# If you are in an environment where qiime2 is not loaded, run this as well:
# conda activate qiime2-2021.11

# Generate a tree for phylogenetic diversity analyses
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences rep-seqs.qza \
  --o-alignment aligned-rep-seqs.qza \
  --o-masked-alignment masked-aligned-rep-seqs.qza \
  --o-tree unrooted-tree.qza \
  --o-rooted-tree rooted-tree.qza 

# Alpha-rarefaction  
qiime diversity alpha-rarefaction \
    --i-table table.qza \
    --i-phylogeny rooted-tree.qza \
    --p-max-depth 8000 \
    --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
    --o-visualization alpha-rarefaction.qzv

# Calculate alpha- and beta-diversity metrics
qiime diversity core-metrics-phylogenetic \
  --i-phylogeny rooted-tree.qza \
  --i-table table-no-mitochondria-no-chloroplast.qza \
  --p-sampling-depth XXXX \
  --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --output-dir core-metrics-results

# Calculate alpha-group-significance
qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/faith_pd_vector.qza \
  --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --o-visualization core-metrics-results/faith-pd-group-significance.qzv

qiime diversity alpha-group-significance \
  --i-alpha-diversity core-metrics-results/evenness_vector.qza \
  --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --o-visualization core-metrics-results/evenness-group-significance.qzv
  
# Calculate beta-group-significance
qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --m-metadata-column body-site \
  --o-visualization core-metrics-results/unweighted-unifrac-body-site-significance.qzv \
  --p-pairwise

qiime diversity beta-group-significance \
  --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
  --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --m-metadata-column subject \
  --o-visualization core-metrics-results/unweighted-unifrac-subject-group-significance.qzv \
  --p-pairwise