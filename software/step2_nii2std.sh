#!/bin/bash

module load fsl
source $FSLDIR/etc/fslconf/fsl.sh

function run_fsl_std() {
	# do some validation of the input folder

	#create output for standard
	stdfolder=$1"/std"
	echo mkdir -p $stdfolder	
	mkdir -p $stdfolder	

	# run fsl reorient2std
	for infile in $(find $1 -maxdepth 1 -mindepth 1 -name "mask_*"); do
		stdfile=$(echo $infile|sed 's/mask/std\/mask/g'|sed 's/\.nii\.gz/_std\.nii\.gz/g')
		echo fslreorient2std $infile $stdfile
		fslreorient2std $infile $stdfile
	done
}


for f in $(find /scratch/cs/faceai/projects/faceai_testingdefacing/data/HNPETCT/processed_CT/ -mindepth 1 -maxdepth 1); do
	run_fsl_std $f
	echo "###"
done

