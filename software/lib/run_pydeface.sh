#!/bin/bash

# do some validation of the input folder
infile=$1
# create output folder
infolder=$(dirname $infile);
filename=$(basename $infile)
outfolder=$infolder"/pydeface"
echo ">> mkdir -p  $outfolder"
mkdir -p  $outfolder

# run pydeface
outfilename="defaced_"$filename
outfile=$outfolder"/"$outfilename
maskfile=$outfolder"/mask.nii.gz"

if [ -f $maskfile ]; then
	echo $maskfile exists so I skip
else

echo ">> pydeface --outfile $outfile $infile"
pydeface --outfile $outfile $infile --nocleanup
# we do manual cleanup
mv -v $infolder/*_pydeface_mask* $maskfile
mv -v $infolder/*_pydeface.mat $outfolder

#echo ">> fslmaths $infile -sub $outfile -binv $maskfile"
#fslmaths $infile -sub $outfile -binv $maskfile

fi
