#!/bin/bash
source /home/despoB/dlurie/.bashrc

subs=(${SGE_TASK_ID})

HOME_CATHERINE=/home/despoB/cathwang/native
COHORT=native_2
stick=${HOME_CATHERINE}/${COHORT}


cd ${stick}

for batch in */ ; do
	echo $batch

	cd ${HOME_CATHERINE}/${COHORT}/${batch}

	
	for folder in */ ; do

		echo $folder

		cd ${HOME_CATHERINE}/${COHORT}/${batch}/${folder}/forks/Output_brain_ANTS/SyN

		cp r_lhemi_in_T1_space.nii.gz ${HOME_CATHERINE}/hemi/native_2/${folder[@]::${#foo[@]}-1}_lhemi.nii.gz
		cp r_rhemi_in_T1_space.nii.gz ${HOME_CATHERINE}/hemi/native_2/${folder[@]::${#foo[@]}-1}_rhemi.nii.gz

	done
done
