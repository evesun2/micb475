#!/bin/bash

# Module 9 code
# If you are in an environment where qiime2 is not loaded, run this as well:
#conda activate qiime2-2021.11

## Export ASV table and distance matrix

qiime tools export \
--input-path ../moving_pictures_tutorial/table.qza \
--output-path table_export 

qiime tools export \
--input-path weighted_unifrac_distance_matrix.qza \
--output-path weighted_unifrac_distance_matrix_export 

qiime tools export \
--input-path ../moving_pictures_tutorial/rooted-tree.qza \
--output-path rooted_tree_export 

qiime tools export \
--input-path ../moving_pictures_tutorial/taxonomy.qza \
--output-path taxonomy_export 

qiime tools export \
--input-path ../moving_pictures_tutorial/core-metrics-results/shannon_vector.qza \
--output-path shannon_exported

qiime tools export \
--input-path rep-seqs.qza \
--output-path rep-seqs_exported

## Export ASV table
biom convert \
-i feature-table.biom \
--to-tsv \
-o feature-table.txt

