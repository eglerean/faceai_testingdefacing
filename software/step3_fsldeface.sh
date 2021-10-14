#!/bin/bash

module load fsl
source $FSLDIR/etc/fslconf/fsl.sh

function run_fsl_deface() {
	# do some validation of the input folder

	#create output for standard
	stdfolder=$1"/std"
	echo mkdir -p $stdfolder	
	mkdir -p $stdfolder	

	# create output folder
	outfolder=$1"/fsl_deface"
	echo mkdir -p  $outfolder
	mkdir -p  $outfolder
	# run fsl deface
	infile=$1"/image.nii.gz"
	stdfile=$1"/std/image_std.nii.gz"
	outmask=$outfolder"/mask"
	outfile=$outfolder"/defaced"
	
	echo fslreorient2std $infile $stdfile
	fslreorient2std $infile $stdfile
	echo fsl_deface $stdfile $outfile -d $outmask
	fsl_deface $stdfile $outfile -d $outmask
}


for f in $(find /scratch/cs/faceai/projects/faceai_testingdefacing/data/HNPETCT/processed_CT/ -mindepth 1 -maxdepth 1); do
	run_fsl_deface $f
	echo "###"
done

