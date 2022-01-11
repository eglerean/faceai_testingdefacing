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
run_maskface.sh /m/cs/scratch/faceai/projects/faceai_testingdefacing/results/OAR_GTV/1/std/1_T2.nii.gz


