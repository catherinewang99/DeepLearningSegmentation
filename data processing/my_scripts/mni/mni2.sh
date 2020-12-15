#!/bin/bash
#source /home/despoB/dlurie/.bashrc

subs=(${SGE_TASK_ID})

HOME_CATHERINE=/home/despoB/cathwang/native/native_1
COHORT=c0002
stick=${HOME_CATHERINE}/${COHORT}

cd ${stick}

# for s in ${subs[@]}
for folder in */ ; do
# do :
	echo $folder
	cd ${HOME_CATHERINE}/${COHORT}/${folder}



	cd forks/Output_brain_ANTS/
	mkdir SyN


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
