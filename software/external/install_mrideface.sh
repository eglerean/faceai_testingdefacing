#!/bin/bash
wget https://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/mri_deface_linux
wget https://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/talairach_mixed_with_skull.gca.gz
wget https://surfer.nmr.mgh.harvard.edu/pub/dist/mri_deface/face.gca.gz
gunzip talairach_mixed_with_skull.gca.gz
gunzip face.gca.gz 
mkdir mri_deface
mv mri_deface_linux mri_deface/mri_deface
chmod a+x mri_deface/mri_deface
mv talairach_mixed_with_skull.gca mri_deface
mv face.gca mri_deface


