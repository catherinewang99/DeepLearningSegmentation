#!/bin/bash
input=1
# study template stuff (no need to change anything here; this is for ANTS)
STUDY_TEMPLATE=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/T_template2.nii.gz
STUDY_TEMPLATE_MASK=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/T_template_BrainCerebellumMask.nii.gz
STUDY_TEMPLATE_POST=/home/despoC/ioannis/Berkeley_research1/stroke/scripts2/segmentation/priors%d.nii.gz

# change this to reflect your, say, batch 1 path
HOME_CATHERINE=/home/despoB/cathwang/native/native_1

# this is just a random t1 from native batch 2 that everything from batch 1 will be resliced to; please change it to an appropriate (random) subject from batch 2
image_from_part2=/home/despoC/ioannis/Berkeley_research1/stroke/data/test_data/for_RAs/Catherine/OutputBrainExtractionBrain_c0011s0004t01.nii.gz
les_from_part2=/home/despoC/ioannis/Berkeley_research1/stroke/data/test_data/for_RAs/Catherine/c0011s0004t01_LesionSmooth.nii.gz

# going back to batch 1 this is the cohort number (the stick); please change it to an appropriate number if needed
COHORT=c0003
stick=${HOME_CATHERINE}/${COHORT}

cd ${stick}

# loop through files in cohort (for now I m doing it only for 3 subjects just to see if it works)
for folder in */ ; do 
	
	cd ${HOME_CATHERINE}/${COHORT}/${folder}
	rm resliced*
        arrayles=($(ls -d *Lesion*nii.gz))
        x=${#arrayles[@]}
        index=x-1
        mkdir ${HOME_CATHERINE}/${COHORT}/${folder}/copies
        for f in *Lesion*nii.gz ; do
           cp ${f} ${HOME_CATHERINE}/${COHORT}/${folder}/copies

        done 

        if [ $x -gt 1 ]
        then 
          inputVolume="${arrayles[$index]}"
          cp ${inputVolume} copy_${inputVolume}
          mv ${inputVolume} start_vol.nii.gz
     
	
          for f in *Lesion*nii.gz ; do
           
             fslmaths ${f} -add start_vol.nii.gz output_vol
             mv output_vol.nii.gz start_vol.nii.gz
          done
        else
             mv ${folder%?}_LesionSmooth.nii.gz start_vol.nii.gz
        fi    

        mv *Lesion* ${HOME_CATHERINE}/${COHORT}/${folder}/copies
        mv start_vol.nii.gz ${folder%?}_mask.nii.gz
        # cd ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS
        # flirt -in OutputBrainExtractionBrain.nii.gz -ref ${image_from_part2} -out r_OutputBrainExtractionBrain.nii.gz -omat transf.mat
        # cd ${HOME_CATHERINE}/${COHORT}/${folder}
        # flirt -in ${folder%?}_mask.nii.gz -ref ${les_from_part2} -out r_${folder%?}_mask.nii.gz -init ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/transf.mat -applyxfm 
done



