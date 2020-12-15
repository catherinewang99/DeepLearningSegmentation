#!/bin/bash
source /home/despoB/dlurie/.bashrc

subs=(${SGE_TASK_ID})

HOME_CATHERINE=/home/despoB/cathwang/native
COHORT=native_2
stick=${HOME_CATHERINE}/${COHORT}

image_from_part2=/home/despoC/ioannis/Berkeley_research1/stroke/data/test_data/for_RAs/Catherine/c0011s0015t01/forks/Output_brain_ANTS/OutputBrainExtractionBrain.nii.gz
# les_from_part2=/home/despoC/ioannis/Berkeley_research1/stroke/data/test_data/for_RAs/Catherine/c0011s0015t01/c0011s0015t01_mask.nii.gz
les_from_part2=/home/despoB/cathwang/native/native_2/c0010/c0010s0001t01/forks/Output_brain_ANTS/SyN/r_rhemi_in_T1_space.nii.gz

batch=c0010
folder=c0010s0044t02


cd ${HOME_CATHERINE}/${COHORT}/${batch}/${folder}/forks/Output_brain_ANTS/SyN

flirt -in rhemi_in_T1_space.nii.gz -ref ${les_from_part2} -out r_rhemi_in_T1_space.nii.gz -init ${HOME_CATHERINE}/${COHORT}/${batch}/${folder}/forks/Output_brain_ANTS/transf.mat -applyxfm 

flirt -in lhemi_in_T1_space.nii.gz -ref ${les_from_part2} -out r_lhemi_in_T1_space.nii.gz -init ${HOME_CATHERINE}/${COHORT}/${batch}/${folder}/forks/Output_brain_ANTS/transf.mat -applyxfm 

