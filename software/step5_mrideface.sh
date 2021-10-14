#!/bin/bash

module load fsl
source $FSLDIR/etc/fslconf/fsl.sh

function run_mrideface() {
	# do some validation of the input folder

	# create output folder
	outfolder=$1"/mri_deface"
	echo mkdir -p  $outfolder
	mkdir -p  $outfolder
	# run fsl deface
	infile=$1"/std/image_std.nii.gz"
	outfile=$outfolder"/defaced.nii.gz"
	if [ -f $outfile ]; then
		echo $outfile exists so I skip
		continue
	fi	

	echo "mri_deface $infile talairach_mixed_with_skull.gca face.gca $outfile"
 	/m/cs/scratch/faceai/projects/faceai_testingdefacing/software/external/mri_deface/mri_deface $infile /m/cs/scratch/faceai/projects/faceai_testingdefacing/software/external/mri_deface/talairach_mixed_with_skull.gca /m/cs/scratch/faceai/projects/faceai_testingdefacing/software/external/mri_deface/face.gca $outfile

}


for f in $(find /scratch/cs/faceai/projects/faceai_testingdefacing/data/HNPETCT/processed_CT/ -mindepth 1 -maxdepth 1); do
	while [ $(ps -fA |grep -i mri_deface|wc -l) -gt 10 ]; do
		sleep 20
		continue
	done
	run_mrideface $f &
	echo "###"
done

