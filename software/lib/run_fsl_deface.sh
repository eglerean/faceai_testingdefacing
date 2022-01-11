#!/bin/bash

infile=$1
infolder=$(dirname $1)
filename=$(basename $1)

# create output folder
outfolder=$infolder"/fsl_deface"
echo ">> mkdir -p  $outfolder"
mkdir -p  $outfolder

# run fsl deface
outmask=$outfolder"/mask"
outfile=$outfolder"/defaced_"$filename
if [ -f $outmask".nii.gz" ]; then
    echo $outmask exists so I skip
else
	echo ">> fsl_deface $infile $outfile -d $outmask"
	fsl_deface $infile $outfile -d $outmask
fi
