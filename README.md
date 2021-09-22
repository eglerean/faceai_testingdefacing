# FACEAI - Testing defacing tools

Code to test existing defacing tools with MRI/PET/CT in head&amp;neck cancer patients.

## Datasets used
Here list of datasets from TCIA.

## Installation
Tools and dependences listed here below:

### Python environment
Run script setup.sh in software/external.
Activate environment with "source deface/bin/activate"
The script also installs **dcmrtstruct2nii** and **pydeface**

### Defacing tools
- pydeface is installed in the python environment
- fsldeface is in our module system `module load fsl`
- mrideface can be installed with softwre/external/install_mrideface.sh
- mask_face can be downloaded from ADDLINK

### Processing tools
- dcmrtstruct2nii is installed in the python environment

## How to run
1. Download the data, currently data is expected to be in a folder outside the repository
2. Run the "step*" scripts in order.

## Processed data
Add here description of output
