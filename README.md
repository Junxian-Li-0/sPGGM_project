## sPGGM

A sample-perturbed Gaussian graphical model for identifying pre-disease stages and signaling molecules of disease progression

## Usage
Download the source codes and unzip the UCEC_sample.rar. The code has been tested in Matlab R2021b.

The implement of sPGGM on TCGA-UCEC dataset is shown as examples in this project. The input data can be changed with theother datasets if necessary.

Running pipeline: main.m

Input data: UCEC_normal.txt, UCEC_tumor.txt, Gene_network.txt;

outputdata: the local sPGGM matrix L_sPGGM.mat and the curve of global sPGGM

## Examples

The TCGA-UCEC dataset consists of 434 tumor samples and 35 adjacent tumor samples. Based on the corresponding clinical information of TCGA, tumor samples are classified into different stages:  stage IA (167 samples), stage IB (148 samples), stage IC (25 samples), stage IIA (6 samples), stage IIB (13 samples), stage IIIA (40 samples), stage IIIB (6 samples), and stage IV (29 samples). The gene expression profiling data can be accessed at: https://portal.gdc.cancer.gov/projects/TCGA-UCEC.
