#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --output=hecktorResampled_%A_%a.out
#SBATCH --array=1-224

# first check that the venv is active

source external/deface/bin/activate
currenv=$(echo $VIRTUAL_ENV|awk -F "/" '{print $NF}');

if [ $currenv != "deface" ]; then
    echo "Your active environment is not =deface=, you might want to run:"
    echo "source external/deface/bin/activate"
    return
fi



export PATH=$PATH:/m/cs/scratch/faceai/projects/faceai_testingdefacing/software/lib/

# add mapping from $SLURM_ARRAY_TASK_ID TO SUBJECT NAME
n=$SLURM_ARRAY_TASK_ID
subject=`sed -n "${n} p" hecktor_resampled.csv`


infile="/scratch/cs/faceai/rawdata/resampled_144_144_144/"$subject"/"$subject"_ct.nii.gz"

outfolder="/m/cs/scratch/faceai/projects/faceai_testingdefacing/results/hecktor_resampled/"
if [ -f $infile ]; then
	process_subject.sh $infile $outfolder
else
	echo "File $infile did not exist"
fi


