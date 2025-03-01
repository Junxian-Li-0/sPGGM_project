# sPGGM: a sample-perturbed Gaussian graphical model for identifying pre-disease stages and signaling molecules of disease progression

## Overview
The proposed sPGGM constructs candidate detection stages at the single-sample level by utilizing a Gaussian graphical model embedded with prior knowledge of the PPI network and quantifies the distributional changes between the baseline and perturbed distributions through the application of optimal transport theory. Then sPGGM score is used to measure the critical transitions of complex diseases, with a marked increase signalling the pre-disease stage.
![fig1](https://github.com/user-attachments/assets/d94dd6a3-5453-4a3a-aea7-6c1d1591c6ba)


## Usage
Download the source codes and unzip the UCEC_sample.rar. The code has been tested in Matlab R2021b and R4.4.1 and Python 3.9
The implement of sPGGM on TCGA-UCEC dataset is shown as examples in this project. The input data can be changed with theother datasets if necessary.
### Step1 Get network from PPI network
#### In python
Run the "construct_network.py" program to obtain the local network of each center gene, which has been tested in Python 3.9.

Input: All gene, e.g. UCEC_gene.txt

Output: The local network file constructed by PPI network——Gene_network.txt

### Step2 Calculate sPGGM score to identify the pre-disease stage
Execute the MATLAB Live Script: main.mlx
### Usage
```mat
local_sPGGM = get_LocalsPGGM(case_data,ref_data,network_path);
```
case_data: gene expression matrix of time-series case samples

ref_data: gene expression matrix of reference samples

network_path: the local network filepath constructed in step1
```
sPGGM = calc_GlobalsPGGM(local_sPGGM,count,patient_label,patient_num);
```
### Step3 Survival analysis
Execute the R script: survival.R

Input: clinical file, e.g. UCEC_clinical.txt

Output: survival curves, which shows a significant difference in prognosis between patients diagnosed before and after the critical stage

## Examples

The TCGA-UCEC dataset consists of 434 tumor samples and 35 adjacent tumor samples. Based on the corresponding clinical information of TCGA, tumor samples are classified into different stages:  stage IA (167 samples), stage IB (148 samples), stage IC (25 samples), stage IIA (6 samples), stage IIB (13 samples), stage IIIA (40 samples), stage IIIB (6 samples), and stage IV (29 samples). The gene expression profiling data can be accessed at: https://portal.gdc.cancer.gov/projects/TCGA-UCEC.
