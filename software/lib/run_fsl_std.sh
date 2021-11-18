# do some validation of the input folder

#create output for standard
stdfolder=$2"/std"
echo ">> mkdir -p $stdfolder"
mkdir -p $stdfolder


# run fsl reorient2std
for infile in $(find $1 -maxdepth 1 -mindepth 1 -name "*.nii*"); do
	stdfile=$(basename $infile)
	echo ">> fslreorient2std $infile $stdfolder/$stdfile"
	if [ -f $stdfolder/$stdfile ]; then
    	echo File exists so I skip
    continue
	fi
	fslreorient2std $infile $stdfolder/$stdfile
done

