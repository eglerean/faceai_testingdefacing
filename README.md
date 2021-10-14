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
2. Run the "step\*" scripts in order.

## Processed data
For different datasets we kept the same subject ID as a subfolder. Inside the subfolder there is the output of the script that converts dicom to niftis.
There is a subfolder called "std" because fsl tools want to work with standard orientation, so all niftis were converted to standard orientation and stored in the "std" subfolder. Then the defacing is applied and each defacing tool output is stored in its own folder.

## TODO
- Pydeface does not produce a defacing mask, so I need to think of a clever way to obtain it (most likely a diff between input and output from pydeface)
- for each annotation label one can compute the overlap with the defacing mask to produce a table like

```
==Example output for 1 defacing tool==

             subj1   subj2   subj3 ...
annotation1  nan	 50.4    nan
annotation2  75.3    nan     12.0
annotation3  nan     nan     nan
..
```
