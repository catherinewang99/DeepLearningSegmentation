#!/bin/bash
input=03
# study template stuff (no need to change anything here; this is for ANTS)
STUDY_TEMPLATE=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/T_template2.nii.gz
STUDY_TEMPLATE_MASK=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/T_template_BrainCerebellumMask.nii.gz
STUDY_TEMPLATE_POST=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/priors%d.nii.gz

# change this to reflect your, say, batch 1 path
HOME_CATHERINE=/home/despoB/cathwang/native/native_1

# this is just a random t1 from native batch 2 that everything from batch 1 will be resliced to; please change it to an appropriate (random) subject from batch 2
image_from_part2=/home/despoC/ioannis/Berkeley_research1/stroke/data/test_data/for_RAs/Catherine/c0011s0015t01/forks/Output_brain_ANTS/OutputBrainExtractionBrain.nii.gz
les_from_part2=/home/despoC/ioannis/Berkeley_research1/stroke/data/test_data/for_RAs/Catherine/c0011s0015t01/c0011s0015t01_mask.nii.gz

# going back to batch 1 this is the cohort number (the stick); please change it to an appropriate number if needed
COHORT=c00${input}
stick=${HOME_CATHERINE}/${COHORT}

cd ${stick}

# loop through files in cohort (for now I m doing it only for 3 subjects just to see if it works)
for folder in */ ; do 
	
        cd ${HOME_CATHERINE}/${COHORT}/${folder}
        flirt -in ${folder%?}_mask.nii.gz -ref ${les_from_part2} -out r_${folder%?}_mask.nii.gz -init ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/transf.mat -applyxfm 
        fslmaths r_${folder%?}_mask.nii.gz -bin bin_r_${folder%?}_mask.nii.gz
done



