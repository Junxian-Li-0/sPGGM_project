# sPGGM: a sample-perturbed Gaussian graphical model for identifying pre-disease stages and signaling molecules of disease progression

## Overview
The proposed sPGGM constructs candidate detection stages at the single-sample level by utilizing a Gaussian graphical model embedded with prior knowledge of the PPI network and quantifies the distributional changes between the baseline and perturbed distributions through the application of optimal transport theory. Then sPGGM score is used to measure the critical transitions of complex diseases, with a marked increase signalling the pre-disease stage.
![fig1](https://github.com/user-attachments/assets/d94dd6a3-5453-4a3a-aea7-6c1d1591c6ba)


## Usage
Download the source codes and upzip the data.rar.
### Examples
The TCGA-UCEC dataset consists of 434 tumor samples and 35 adjacent tumor samples. Based on the corresponding clinical information of TCGA, tumor samples are classified into different stages:  stage IA (167 samples), stage IB (148 samples), stage IC (25 samples), stage IIA (6 samples), stage IIB (13 samples), stage IIIA (40 samples), stage IIIB (6 samples), and stage IV (29 samples). The gene expression profiling data can be accessed at: https://portal.gdc.cancer.gov/projects/TCGA-UCEC. The UCEC data is saved in '../data/'.

### Step1 Get network from PPI network
Obtain the network from PPI network from STRING (https://cn.string-db.org/).

### Step2 Calculate sPGGM score to identify the pre-disease stage
Execute the MATLAB Live Script: main.mlx, which has been tested successfully in Matlab R2021b.
### Usage
```matlab
local_sPGGM = get_LocalsPGGM(case_data,ref_data,network_path);
%% case_data: gene expression matrix of time-series case samples
%% ref_data: gene expression matrix of reference samples
%% network_path: the local network filepath constructed in step1
```
case_data and ref_data figure
```matlab
sPGGM = calc_GlobalsPGGM(local_sPGGM,count,patient_label,patient_num);
%% local_sPGGM: the output matrix from get_LocalsPGGM function
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

Output: survival curves, which shows a significant difference in prognosis between patients diagnosed before and after the critical stage

## Citation
Jiayuan Zhong, Junxian Li, et al."sPGGM: a sample-perturbed Gaussian graphical model for identifying pre-disease stages and signaling molecules of disease progression"
