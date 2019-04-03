#!/bin/bash

printf "Downloading $1 from Dynasty Scans"
if [ ! -z $2 ]; then
	check=1
	printf " starting at $2"
else
	check=0
fi
printf ".\n"

printf "Remember to use ctrl+z, not ctrl+c, to stop the script if needed.\n\n"

list=`curl -s https://dynasty-scans.com/series/$1 | pcregrep -o '(?<=href\=")[^"]*(?="\sclass\="name")'`

# echo $list
echo $check

for chap in $list; do
	# eval curl -s https://dynasty-scans.com$chap | pcregrep -o '(?<=\<title\>)[^\<]*(?=\<)'
	short=`echo $chap | pcregrep -o "(?<=$1_).*$"`
	echo $short

	if [ $check -eq 1 ]; then
		if [ "$short" = "$2" ]; then
			check=false
		else
			echo "Skipping"
			continue
		fi
	fi

	# echo $short
	eval curl https://dynasty-scans.com$chap/download -o archive_$short
	if [ $(wc -c < "archive_$short") -ge 1000 ]; then
		eval mkdir $short
		eval 7z e archive_$short -o$short
		eval rm archive_$short
	else
		eval rm archive_$short
		echo "Download limit reached. When ready, rerun this command with the extra argument:"
		echo "$short"
		exit 1;
	fi
	
	echo "Download complete!"
done
