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

# if we are here, then environemnt is set and we are ready to go

basepath="/m/cs/scratch/faceai/rawdata/TCIA_data/HNPETCT/manifest-VpKfQUDr2642018792281691204/"
s=0;
for u in $(cat $basepath"metadata.csv" |grep ",RTstructCTsim-CTPET-CT,"|cut -d, -f5-6); do 
	numctfile=$(grep $u $basepath"metadata.csv"|cut -d, -f 11,16|grep "^CT,"|grep -v "kVCT"|wc -l);
	ctfile=$(grep $u $basepath"metadata.csv"|cut -d, -f 11,16|grep "^CT,"|grep -v "kVCT"|cut -d, -f2);
	numrtfile=$(grep $u $basepath"metadata.csv"|grep RTstructCTsim-CTPET-CT|cut -d, -f16|wc -l); 
	rtfile=$(grep $u $basepath"metadata.csv"|grep RTstructCTsim-CTPET-CT|cut -d, -f16); 
	if [ $numctfile -ne 1 ]; then
		
		echo "CT "$numctfile
		echo $ctfile
	fi
	if [ $numrtfile -ne 1 ]; then
		echo "RT "$numrtfile
		echo $rtfile
	fi
	# now find the right name
	# due to spaces the names in the csv are wrong

	ctID=$(echo ${ctfile: -5});
	searchpath=$(echo $ctfile|cut -d\/ -f 1-3);
	goodctfile=$(find $basepath$searchpath -type d|grep $ctID| sed 's/ /\\ /g');
	
	rtID=$(echo ${rtfile: -5});
	searchpath=$(echo $rtfile|cut -d\/ -f 1-3);
	goodrtfile=$(find $basepath$searchpath -type d|grep $rtID| sed 's/ /\\ /g'|grep RT); # added grep RT 

	# testing shoudl be added to check we have only one folder for CT and one for RT

	# testing:
	# echo "\""$ctfile"\" \""$rtfile"\"";
	
	# increasing subject counter, not in use:
	# let s=s+1;
	# subfolder=$(printf "%03d" $s)

	
	origuser=$(echo $u|cut -d, -f1);
	outputfolder="/m/cs/scratch/faceai/projects/faceai_testingdefacing/data/HNPETCT/processed_CT/"$origuser
	timestamp=$(date +'%Y%m%d%H%M%S');
	logfile=$outputfolder"/log_"$timestamp".log"
	donefile=$outputfolder"/"$origuser".done"	

	# if already done, skip it
	if [ -f $donefile ]; then
		echo "Looks like $donefile exists, skipping this subject"
		continue
	else
		echo "Processing $origuser in $outputfolder"
	fi
	
	echo mkdir -p $outputfolder
	mkdir -p $outputfolder
	command=$(echo "dcmrtstruct2nii  convert --rtstruct "$goodrtfile/1-1.dcm" --dicom  "$goodctfile" --output "$outputfolder);
	echo $command 2>&1|tee $logfile
	eval $command 2>&1|tee $logfile
	issuccess=$(cat $logfile|grep "Success"|wc -l);
	if [ $issuccess -eq 1 ]; then
		touch $donefile
	else
		echo "Something went wrong with $origuser at $outputfolder"
		return
	fi
done
exit
