#!/bin/bash

# Module 4 code

# If you are in an environment where qiime2 is not loaded, run this as well:
conda activate qiime2-2021.11

# Create a directory for your project and navigate to it
mkdir /data/moving_pictures_tutorial
cd /data/moving_pictures_tutorial

# Import data while working directory is `/data/moving_pictures_tutorial`
qiime tools import \
  --type EMPSingleEndSequences \
  --input-path /mnt/datasets/project_1/moving_pictures/emp-single-end-sequences \
  --output-path emp-single-end-sequences.qza
  
# Look at artifact information
qiime tools peek emp-single-end-sequences.qza

# To import a dataset using a manifest file
qiime tools import \
  --type "SampleData[SequencesWithQuality]" \
  --input-format SingleEndFastqManifestPhred33V2 \
  --input-path ./manifest.tsv \
  --output-path ./demux_seqs.qza

# Demultiplexing
qiime demux emp-single \
  --i-seqs emp-single-end-sequences.qza \
  --m-barcodes-file /mnt/datasets/project_1/moving_pictures/sample-metadata.tsv \
  --m-barcodes-column barcode-sequence \
  --o-per-sample-sequences demux.qza \
  --o-error-correction-details demux-details.qza

# Create visualization of demultiplexed samples
qiime demux summarize \
  --i-data demux.qza \
  --o-visualization demux.qzv