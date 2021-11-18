#!/bin/bash
#!/bin/bash
module load fsl/6.0.3
source $FSLDIR/etc/fslconf/fsl.sh

MASKFACE_HOME=/scratch/cs/faceai/projects/faceai_testingdefacing/software/external/MaskFace/lin64.Dec2017
PATH=${MASKFACE_HOME}/bin:${PATH}

export PATH MASKFACE_HOME

module load matlab/r2018a

# do some validation of the input folder

curr_dirr=$(pwd)

infile=$1
# create output folder
infolder=$(dirname $infile);
outfolder=$infolder"/mask_face/"
echo ">> mkdir -p  $outfolder"
mkdir -p  $outfolder
cd $outfolder


# run maskface
echo ">> fslchfiletype NIFTI_PAIR $infile $outfolder"/image_std""
fslchfiletype NIFTI_PAIR $infile $outfolder"/image_std"
    
infile_MF="image_std"
outfile="defaced"
    
if [ -f $outfile".nii" ]; then
	echo $outfile exists so I skip
else
	echo ">> mask_face $infile_MF -a -o $outfile"
	mask_face $infile_MF -a -o $outfile
	

fi


