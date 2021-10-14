#!/bin/bash
module load fsl/6.0.3
source $FSLDIR/etc/fslconf/fsl.sh

MASKFACE_HOME=/scratch/cs/faceai/projects/faceai_testingdefacing/software/external/MaskFace/lin64.Dec2017
PATH=${MASKFACE_HOME}/bin:${PATH}

export PATH MASKFACE_HOME

module load matlab/r2018a


function run_maskface() {
	# do some validation of the input folder

	# create output folder
	outfolder=$1"/facemask"
	echo mkdir -p  $outfolder
	mkdir -p  $outfolder
	# run fsl deface
	stdfile=$1"/std/image_std.nii.gz"
	echo fslchfiletype NIFTI_PAIR $stdfile $outfolder"/image_std"
	#fslchfiletype NIFTI_PAIR $stdfile $outfolder"/image_std"
	infile=$outfolder"/image_std"

	outfile=$outfolder"/defaced"
	if [ -f $outfile ]; then
		echo $outfile exists so I skip
		continue
	fi	

	echo "mask_face $infile -a -o $outfile"
}


for f in $(find /scratch/cs/faceai/projects/faceai_testingdefacing/data/HNPETCT/processed_CT/ -mindepth 1 -maxdepth 1); do
	while [ $(ps -fA |grep -i mask_face|wc -l) -gt 10 ]; do
		sleep 20
		continue
	done
	run_maskface $f 
	echo "###"
done

