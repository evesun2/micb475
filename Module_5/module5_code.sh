#!/bin/bash

# Module 5 code

# If you are in an environment where qiime2 is not loaded, run this as well:
# conda activate qiime2-2021.11

# Determine ASVs with DADA2
qiime dada2 denoise-single \
  --i-demultiplexed-seqs demux.qza \
  --p-trim-left 0 \
  --p-trunc-len 120 \
  --o-representative-sequences rep-seqs.qza \
  --o-table table.qza \
  --o-denoising-stats stats.qza
  
# Visualize DADA2 stats
qiime metadata tabulate \
  --m-input-file stats.qza \
  --o-visualization stats.qzv

# Visualize ASVs stats
qiime feature-table summarize \
  --i-table table.qza \
  --o-visualization table.qzv \
  --m-sample-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv
  
qiime feature-table tabulate-seqs \
  --i-data rep-seqs.qza \
  --o-visualization rep-seqs.qzv