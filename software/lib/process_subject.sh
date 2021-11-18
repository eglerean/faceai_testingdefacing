#!/bin/bash

module load fsl
source $FSLDIR/etc/fslconf/fsl.sh



echo ">> Example"
echo ">> process_subject.sh /m/cs/scratch/faceai/rawdata/OAR_GTV/1/1_T2.nii.gz /m/cs/scratch/faceai/projects/faceai_testingdefacing/results/"
echo
indir=$(dirname $1)
infile=$(basename $1)
subjID=$(basename $indir)
outdir=$2/$subjID/


run_fsl_std.sh $indir $outdir
echo

run_fsl_deface.sh $outdir/std/$infile 
echo


run_pydeface.sh  $outdir/std/$infile
echo

run_mrideface.sh $outdir/std/$infile
echo

# fsl version changes here 
#run_maskface.sh $outdir/std/$infile
echo
