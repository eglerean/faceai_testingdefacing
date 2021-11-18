#!/bin/bash

infile=$1
infolder=$(dirname $1)

# create output folder
outfolder=$infolder"/fsl_deface"
echo ">> mkdir -p  $outfolder"
mkdir -p  $outfolder

# run fsl deface
outmask=$outfolder"/mask"
outfile=$outfolder"/defaced"
if [ -f $outfile".nii.gz" ]; then
    echo $outfile exists so I skip
else
	echo ">> fsl_deface $infile $outfile -d $outmask"
	fsl_deface $infile $outfile -d $outmask
fi
