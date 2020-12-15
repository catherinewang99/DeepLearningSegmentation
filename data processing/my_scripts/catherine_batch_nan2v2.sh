#!/bin/bash
input=${SGE_TASK_ID}
# study template stuff (no need to change anything here; this is for ANTS)
STUDY_TEMPLATE=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/T_template2.nii.gz
STUDY_TEMPLATE_MASK=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/T_template_BrainCerebellumMask.nii.gz
STUDY_TEMPLATE_POST=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/priors%d.nii.gz
source /home/despoB/dlurie/.bashrc
# change this to reflect your, say, batch 1 path
HOME_CATHERINE=/home/despoB/cathwang/native/native_2

# this is just a random t1 from native batch 2 that everything from batch 1 will be resliced to; please change it to an appropriate (random) subject from batch 2
image_from_part2=/home/despoB/cathwang/native/native_2/c0006/c0006s0005t01/c0006s0005t01.nii.gz


# going back to batch 1 this is the cohort number (the stick); please change it to an appropriate number if needed
COHORT=c00${input}
stick=${HOME_CATHERINE}/${COHORT}

cd ${stick}

# loop through files in cohort (for now I m doing it only for 3 subjects just to see if it works)
for folder in */ ; do 
	
	
	cd ${HOME_CATHERINE}/${COHORT}/${folder}
	# mkdir ${HOME_CATHERINE}/${COHORT}/${folder}/forks/
	# mkdir ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS
	
	cd ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS
	# this is the brain extraction
	antsBrainExtraction.sh -d 3 -o Output -a ${HOME_CATHERINE}/${COHORT}/${folder}/${folder%?}.nii.gz -e ${STUDY_TEMPLATE} -m ${STUDY_TEMPLATE_MASK}
	# this is the reslicing part to the random image from batch 2 (I am reslicing both the brain extracted image and the mask)
	# antsApplyTransforms -d 3 -i OutputBrainExtractionBrain.nii.gz -o _t1w_resliced_stx -r ${image_from_part2} -t identity -n NearestNeighbor --float 1
        
	cd ${HOME_CATHERINE}/${COHORT}/${folder}
	# this is the reslicing part for all the masks...
        for f in *_mask*nii.gz ; do
          antsApplyTransforms -d 3 -i ${f} -o resliced_${f} -r ${image_from_part2} -t identity -n NearestNeighbor --float 1
        done
done
















