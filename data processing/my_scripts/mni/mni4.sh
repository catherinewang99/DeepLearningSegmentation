#!/bin/bash
source /home/despoB/dlurie/.bashrc

subs=(${SGE_TASK_ID})

HOME_CATHERINE=/home/despoB/cathwang/native/native_1
COHORT=c0004
stick=${HOME_CATHERINE}/${COHORT}

cd ${stick}

# for s in ${subs[@]}
for folder in */ ; do
# do :
	echo $folder
	cd ${HOME_CATHERINE}/${COHORT}/${folder}


	# I inverse the mask (0's are 1's and 1's are 0's) the result is x_lesionMaskNeg
        ImageMath 3 bin_r_${folder%?}_lesionMaskNeg.nii.gz Neg bin_r_${folder%?}_mask.nii.gz
        
	# I register the MNI template to the brain image (leave the -m path as it is as this is the standard MNI template)

	cd forks/Output_brain_ANTS/
	mkdir SyN

	antsRegistrationSyN.sh \
		-d 3 \
		-f ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/OutputBrainExtractionBrain.nii.gz \
		-m /home/despoC/ioannis/Imaging_general/MNI_templates/MNI152_T1_1mm_Brain.nii.gz \
		-x ${HOME_CATHERINE}/${COHORT}/${folder}/bin_r_${folder%?}_lesionMaskNeg.nii.gz \
		-o ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/SyN/MNItoT1_


        # now I use the transform to math the RHmaskMNI to T1 space (leave the -i as it is as this is the standard MNI right hemisphere mask)
	antsApplyTransforms \
			-d 3 \
			-i /home/despoB/rmohyee/asl/ANTs/RHmaskMNI.nii.gz \
			-r ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/OutputBrainExtractionBrain.nii.gz -t ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/SyN/MNItoT1_0GenericAffine.mat -t ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/SyN/MNItoT1_1Warp.nii.gz -n NearestNeighbor \
			--float \
			-v \
			-o ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/SyN/rhemi_in_T1_space.nii.gz 

       # now I use the transform to math the LHmaskMNI to T1 space (leave the -i as it is as this is the standard MNI left hemisphere mask)
         antsApplyTransforms \
			-d 3 \
			-i /home/despoB/rmohyee/asl/ANTs/LHmaskMNI.nii.gz \
			-r ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/OutputBrainExtractionBrain.nii.gz -t ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/SyN/MNItoT1_0GenericAffine.mat -t ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/SyN/MNItoT1_1Warp.nii.gz -n NearestNeighbor \
			--float \
			-v \
			-o ${HOME_CATHERINE}/${COHORT}/${folder}/forks/Output_brain_ANTS/SyN/lhemi_in_T1_space.nii.gz 
done
