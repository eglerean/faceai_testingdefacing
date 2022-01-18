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
	echo ">> mask_face $infile_MF -a -e 1 -o $outfile"
	mask_face $infile_MF -a -e 1 -o $outfile
fi

## now move the masked image to the main folder
# first get the output to the parent folder
echo fslmaths $outfolder/maskface/image_std_full_normfilter -mul 1 $outfolder/defaced.nii.gz -odt float
fslmaths $outfolder/maskface/image_std_full_normfilter -mul 1 $outfolder/defaced.nii.gz -odt float
echo fslmaths $outfolder/maskface/image_std -mul 1 $outfolder/temp.nii.gz -odt float
fslmaths $outfolder/maskface/image_std -mul 1 $outfolder/temp.nii.gz -odt float
# then fix the header of the defaced
echo fslcpgeom $outfolder/temp.nii.gz $outfolder/defaced.nii.gz
fslcpgeom $outfolder/temp.nii.gz $outfolder/defaced.nii.gz
# now subtract to make the mask
echo fslmaths $outfolder/temp.nii.gz -sub $outfolder/defaced.nii.gz -abs -bin $outfolder/tempmask.nii.gz
fslmaths $outfolder/temp.nii.gz -sub $outfolder/defaced.nii.gz -abs -bin $outfolder/tempmask.nii.gz
# now fill the holes in the mask
echo fslmaths $outfolder/tempmask.nii.gz -fillh $outfolder/mask.nii.gz
fslmaths $outfolder/tempmask.nii.gz -fillh $outfolder/mask.nii.gz


