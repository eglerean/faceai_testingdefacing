#!/bin/bash

# do some validation of the input folder
infile=$1
# create output folder
infolder=$(dirname $infile);
outfolder=$infolder"/pydeface"
echo ">> mkdir -p  $outfolder"
mkdir -p  $outfolder

# run pydeface
outfile=$outfolder"/defaced.nii.gz"
maskfile=$outfolder"/mask.nii.gz"

if [ -f $outfile ]; then
	echo $outfile exists so I skip
else

echo ">> pydeface --outfile $outfile $infile"
pydeface --outfile $outfile $infile

echo ">> fslmaths $infile -sub $outfile -binv $maskfile"
fslmaths $infile -sub $outfile -binv $maskfile

fi
