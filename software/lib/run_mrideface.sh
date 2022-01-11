#!/bin/bash

# do some validation of the input folder
infile=$1
# create output folder
infolder=$(dirname $infile);
filename=$(basename $1)
outfolder=$infolder"/mrideface"
echo ">> mkdir -p  $outfolder"
mkdir -p  $outfolder
# run mrideface
outfile=$outfolder"/defaced_"$filename
maskfile=$outfolder"/mask.nii.gz"
if [ -f $maskfile ]; then
	echo $maskfile exists so I skip
else
	echo ">> mri_deface $infile talairach_mixed_with_skull.gca face.gca $outfile"
	/m/cs/scratch/faceai/projects/faceai_testingdefacing/software/external/mri_deface/mri_deface $infile /m/cs/scratch/faceai/projects/faceai_testingdefacing/software/external/mri_deface/talairach_mixed_with_skull.gca /m/cs/scratch/faceai/projects/faceai_testingdefacing/software/external/mri_deface/face.gca $outfile


echo ">> fslmaths $infile -sub $outfile -binv $maskfile"
fslmaths $infile -sub $outfile -binv $maskfile

fi
