#!/bin/bash

# Module 6 code

# If you are in an environment where qiime2 is not loaded, run this as well:
# conda activate qiime2-2021.11

# Taxonomic analysis
qiime feature-classifier classify-sklearn \
  --i-classifier /mnt/datasets/classifiers/silva-138-99-515-806-nb-classifier.qza \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza

qiime metadata tabulate \
  --m-input-file taxonomy.qza \
  --o-visualization taxonomy.qzv
  
# Taxonomy barplots
qiime taxa barplot \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --o-visualization taxa-bar-plots.qzv

# Extract your amplicon of interest from the reference database
#replace the ref-otus.qza with the representative sequence file on the server (e.g. /mnt/datasets/silva_ref_files/silva-138-99-seqs.qza)
#replace primer sequences with your correct sequences
#replace trunc-len with the one you defined in your denoising step
qiime feature-classifier extract-reads \
  --i-sequences ref-otus.qza \
  --p-f-primer GTGCCAGCMGCCGCGGTAA \
  --p-r-primer GGACTACHVGGGTWTCTAAT \
  --p-trunc-len 150 \
  --o-reads ref-seqs-trimmed.qza


 # Train classifier with your new ref-seq file
# Replace ref-taxonomy.qza with the representative taxonomy file on the server (e.g. /mnt/datasets/silva_ref_files/silva-138-99-tax.qza)
qiime feature-classifier fit-classifier-naive-bayes \
  --i-reference-reads ref-seqs-trimmed.qza \
  --i-reference-taxonomy ref-taxonomy.qza \
  --o-classifier classifier.qza

# Use the trained classifier to assign taxonomy to your reads (rep-seqs.qza)
qiime feature-classifier classify-sklearn \
  --i-classifier classifier.qza \
  --i-reads rep-seqs.qza \
  --o-classification taxonomy.qza

# Filter out mitochondrial and chloroplast ASVs
qiime taxa filter-table \
  --i-table table.qza \
  --i-taxonomy taxonomy.qza \
  --p-exclude mitochondria,chloroplast \
  --o-filtered-table table-no-mitochondria-no-chloroplast.qza

# Frequency-based filtering to remove rare ASVs
# To calculate what is considered to be rare ASVs = total #reads x 0.00005
qiime feature-table filter-features \
--i-table table.qza \
--p-min-frequency 8 \
--o-filtered-table feature-frequency-filtered-table.qza

# Metadata-based filtering to keep only subject 1 samples
qiime feature-table filter-samples \
  --i-table table-no-mitochondria-no-chloroplast.qza \
  --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --p-where "[subject]='subject-1'" \
  --o-filtered-table subject-1-filtered-table.qza

# Filter to keep only left and right palm samples
qiime feature-table filter-samples \
  --i-table table-no-mitochondria-no-chloroplast.qza \
  --m-metadata-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --p-where "[body-site] IN ('left palm', 'right palm')" \
  --o-filtered-table skin-filtered-table.qza
