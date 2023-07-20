# MICB 475: Data Science Research in Microbiology
This repository stores all the online module components of UBC's MICB 475: Data science research in microbiology course

## Summary
MICB 475 is a data science course-based undergraduate research experience (CURE) developed at the University of British Columbia's Department of Microbiology and Immunology. The courses focuses on amplicon sequencing data as a gateway into data science research. The course consists of 4 phases: scaffolding, planning, experimentation, and dissemination. This repository focuses on the hybrid scaffolding phase of the course where students learn command line and QIIME2 (Modules 1-8) and R/RStudion (Modules 9-18) using the Moving Pictures Tutorial dataset (https://docs.qiime2.org/2022.2/tutorials/moving-pictures/).

Modules are comprised of video tutorials, markdown scripts, and coding exercises. 

<img src="images/pic_1.png" width="300"/><img src="images/pic_2.png" width="500"/>

## Rationale for hybrid model
The benefits of this delivery mode for a data science course of this nature includes:
  * it serves a wider range of prior expertise in a more optimal manner than the course when it was completely online or completely in person
  * it is modelled after how other units like computer science teach some of their data science courses or programs
  * this model complements a mix of hands-on practice and theory in a less constrained manner compared to synchronous modes of delivery

[Feedback collected from students](#feedback) during the first iteration of this course speak to its effectiveness in teaching beginners data science but still challenging students who enter the course with a stronger data science background. 

## Table of Contents
   * [Module 1: Navigating your directory using your terminal](#module-1)
   * [Module 2: Logging in to the server](#module-2)
   * [Module 3: Measuring the microbiome through amplicon sequencing](#module-3)
   * [Module 4: Importing and demultiplexing](#module-4)
   * [Module 5: Determining your amplicon sequencing variants (ASVs)](#module-5)
   * [Module 6: Taxonomic analysis and data filtering](#module-6)
   * [Module 7: Diversity metrics](#module-7)
   * [Module 8: Getting started with Project 2](#module-8)
   * [Module 9]

## Module 1
### Navigating your directory using your terminal
By the end of this module, if all practice activities and tutorials are completed, a student will be able to:
1. Differentiate between the shell and kernel of your computing system
2. Open up your computer's terminal (ie. command line interface) 
3. Use basic bash commands to navigate your local environment

<img src="images/pic_3.png" width="500"/><img src="images/pic_4.png" width="500"/>

**Example exercise**:

You start in the directory experiment and execute the following commands:
<pre>
mkdir raw_data
mkdir processed_data
cd raw_data
mkdir sequences
cd sequences
touch bacteria_1.txt
cd ..
touch sequences/bacteria_2.txt
cd ..
mkdir raw_data/metadata
touch raw_data/metadata/metadata.txt
cp raw_data/sequences/bacteria_1.txt processed_data/bacteria_1_analysed.txt
cd processed_data
cp ../raw_data/sequences/bacteria_2.txt bacteria_2_analysed.txt
rm bacteria_1_analysed.txt
</pre>
Without executing the commands, predict the file structure including all directories and files in the directory experiment?

## Module 2
### Logging in to the server
By the end of this module, if all practice activities and tutorials are completed, a student will be able to:
1. Access our remote server
2. Navigate the server using the commands learned in Module 1
3. Transfer files to and from the server
4. Run background jobs

<img src="images/pic_5.png" width="500"/>

Weekly assignment: draw out the file path for the <code>/mnt</code> (mount) folder in the server

## Module 3
### Measuring the microbiome through amplicon sequencing
By the end of this module, if all practice activities and tutorials are completed, a student will be able to:
1. Define what the microbiome is and why it is important
2. Describes the steps involved in Amplicon Sequencing
3. Explain what are the possible outputs (ie. files and data) from amplicon sequencing

<img src="images/pic_6.png" width="500"/><img src="images/pic_7.png" width="500"/>

## Module 4
### Importing and demultiplexing
By the end of this module, if all practice activities and tutorials are completed, a student will be able to:
1. Import different types of sequencing files into QIIME2 with or without a manifest file
2. Demultiplex using QIIME2

<img src="images/pic_8.png" width="500"/><img src="images/pic_9.png" width="500"/>

## Module 5
### Determining your amplicon sequence variants (ASVs)
By the end of this module, if all practice activities and tutorials are completed, a student will be able to:
1. Denoise your data by trimming your reads and removing low quality reads using DADA2 or Deblur
2. Cluster unique reads in your data called Amplicon Sequence Variants (ASVs)
3. Distinguish between ASVs and OTUs

<img src="images/pic_10.png" width="500"/>

## Module 6
### Taxonomic analysis and data filtering
By the end of this module, if all practice activities and tutorials are completed, a student will be able to:
1. Train a classifier to do taxonomic analysis
2. Generate and interpret a taxa bar graph
3. Filter your ASV table based on taxonomy, frequency, or metadata

<img src="images/pic_11.png" width="500"/><img src="images/pic_12.png" width="500"/>

## Module 7
### Diversity Metrics
By the end of this module, if all practice activities and tutorials are completed, a student will be able to:
1. Define “microbial diversity” based on 3 key parameters
2. Rarefy your data before running your diversity metrics analysis
3. Interpret box plots and principle component analyses (PCA)

<img src="images/pic_13.png" width="500"/><img src="images/pic_14.png" width="500"/>

## Module 8
### Getting started with project 2
The synchronous components of the course begin during this week where student teams of 3-4 meet weekly with the teaching team to start to develop their research proposals and ultimately carry out their capstone research projects for the remainder of the course. Students will present their findings at the end of the term as an oral presentation and written manuscript to be published in the [Undergradute Journal of Experimental Microbilogy and Immonology](https://jemi.microbiology.ubc.ca/).
