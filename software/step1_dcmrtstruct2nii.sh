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
	goodrtfile=$(find $basepath$searchpath -type d|grep $rtID| sed 's/ /\\ /g');

	# testing:
	# echo "\""$ctfile"\" \""$rtfile"\"";
	
	# increasing subject counter, not in use:
	# let s=s+1;
	# subfolder=$(printf "%03d" $s)

	
	origuser=$(echo $u|cut -d, -f1);
	outputfolder="/m/cs/scratch/faceai/projects/defacing_202109/data/HNPETCT/processed_CT/"$origuser
	mkdir -p $outputfolder
	echo "dcmrtstruct2nii  convert --rtstruct "$goodrtfile/1-1.dcm" --dicom  "$goodctfile" --output "$outputfolder;
	
done
