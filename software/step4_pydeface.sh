#!/bin/bash

module load fsl
source $FSLDIR/etc/fslconf/fsl.sh

function run_pydeface() {
	# do some validation of the input folder

	# create output folder
	outfolder=$1"/pydeface"
	echo mkdir -p  $outfolder
	mkdir -p  $outfolder
	# run fsl deface
	infile=$1"/std/image_std.nii.gz"
	outfile=$outfolder"/defaced.nii.gz"
	if [ -f $outfile ]; then
		echo $outfile exists so I skip
		continue
	fi	

	echo "pydeface --outfile $outfile $infile"
	pydeface --outfile $outfile $infile
}


for f in $(find /scratch/cs/faceai/projects/faceai_testingdefacing/data/HNPETCT/processed_CT/ -mindepth 1 -maxdepth 1); do
	while [ $(ps -fA |grep -i pydeface|wc -l) -gt 10 ]; do
		sleep 20
		continue
	done
	run_pydeface $f &
	echo "###"
done

