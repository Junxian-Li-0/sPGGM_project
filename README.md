# sPGGM: a sample-perturbed Gaussian graphical model for identifying pre-disease stages and signaling molecules of disease progression

## Overview
Complex disease progression typically involves sudden and non-linear transitions accompanied by the devastating effects. Uncovering such critical states or pre-disease stages and discovering dynamic network biomarkers (signaling molecules) is vital for both comprehending disease progression and preventing or delaying disease deterioration. In this study, based on optimal transport theory and Gaussian graphical models, we present an innovative computational framework, the sample-perturbed Gaussian graphical model (sPGGM), designed to analyse disease progression and identify pre-disease stages at the specific sample/cell level. The proposed sPGGM constructs candidate detection stages at the single-sample level by utilizing a Gaussian graphical model embedded with prior knowledge of the PPI network and quantifies the distributional changes between the baseline and perturbed distributions through the application of optimal transport theory. Then sPGGM score is used to measure the critical transitions of complex diseases, with a marked increase signalling the pre-disease stage.
![image](https://github.com/user-attachments/assets/cb45ac8a-8c22-4a47-819e-be56b0b0b23c)




## Usage
Download the source codes and upzip the data.zip.
### Examples
The TCGA-UCEC dataset consists of 434 tumor samples and 35 adjacent tumor samples. Based on the corresponding clinical information of TCGA, tumor samples are classified into different stages:  stage IA (167 samples), stage IB (148 samples), stage IC (25 samples), stage IIA (6 samples), stage IIB (13 samples), stage IIIA (40 samples), stage IIIB (6 samples), and stage IV (29 samples). The gene expression profiling data can be accessed at: https://portal.gdc.cancer.gov/projects/TCGA-UCEC. The UCEC data is saved in '../data/'.

### Step1. Get network from PPI network
Obtain the network from PPI network from STRING (https://cn.string-db.org/).

### Step2. Calculate sPGGM score to identify the pre-disease stage
Execute the MATLAB Live Script: main.mlx, which has been tested in Matlab R2021b.
#### Usage
```matlab
local_sPGGM = get_LocalsPGGM(case_data,ref_data,network_path);
%% case_data: gene expression matrix of time-series case samples
%% ref_data: gene expression matrix of reference samples
%% network_path: the local network file e.g. UCEC_Gene_network.txt
```
![fig2](https://github.com/user-attachments/assets/5a6abb4a-9f6f-4eec-98f5-7eaa689616fa)

```matlab
sPGGM = calc_GlobalsPGGM(local_sPGGM,count,patient_label,patient_num);
%% local_sPGGM: the output matrix from get_LocalsPGGM function
%% count: signaling molecules num
%% patient_label: the output array from get_stage function
%% patient_num: the output array from get_stage function
```
The parameters 'patient_label' and 'patient_num' can be generated as follow:
```matlab
[stage_lab,patient_label,patient_num]=get_stage('./data/UCEC_stage.txt');
```
### Step3 Survival analysis
Execute the R script: survival.R, which has been tested successfully in R4.4.1.

Input: clinical information, e.g. UCEC_clinical.txt

Output: survival curves(survival.png), which shows a significant difference in prognosis between patients diagnosed before and after the critical stage

## Citation
Jiayuan Zhong, Junxian Li, et al. sPGGM: a sample-perturbed Gaussian graphical model for identifying pre-disease stages and signaling molecules of disease progression

## Contact
Jiayuan Zhong: Zjiayuan@foshan.edu.cn

Junxian Li: junxianli0103@163.com
