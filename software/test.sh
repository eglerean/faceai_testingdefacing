#!/bin/bash

# first check that the venv is active

if [ -z $VIRTUAL_ENV ]; then
    echo "Virtual environment is not active, you might want to run:"
    echo "source external/deface/bin/activate"
    return
fi

currenv=$(echo $VIRTUAL_ENV|awk -F "/" '{print $NF}');

if [ $currenv != "deface" ]; then
    echo "Your active environment is not =deface=, you might want to run:"
    echo "source external/deface/bin/activate"
    return
fi

export PATH=$PATH:/m/cs/scratch/faceai/projects/faceai_testingdefacing/software/lib/
#process_subject.sh   /m/cs/scratch/faceai/rawdata/OAR_GTV/2/2_T2.nii.gz /m/cs/scratch/faceai/projects/faceai_testingdefacing/results/test/
#process_subject.sh  /m/cs/scratch/faceai/projects/faceai_testingdefacing/data/AAPM/processed_MRI/RTMAC-LIVE-001/image.nii.gz /m/cs/scratch/faceai/projects/faceai_testingdefacing/results/test/
process_subject.sh /scratch/cs/faceai/rawdata/resampled_144_144_144/CHUM061/CHUM061_ct.nii.gz /m/cs/scratch/faceai/projects/faceai_testingdefacing/results/test/
