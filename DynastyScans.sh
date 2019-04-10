#!/bin/bash

case `uname` in
	Darwin)
		echo "Detected macOS. Using pcregrep"
		grep="pcregrep"
		;;
	Linux)
		echo "Detectd Linux. Using grep -P"
		grep="grep -P"
		;;
	*)
		echo "Unrecognized OS. Trying pcregrep"
		grep="pcregrep"
		;;
esac

printf "Downloading $1 from Dynasty Scans"
if [ ! -z $2 ]; then
	check=1
	printf " starting at $2"
else
	check=0
fi
printf ".\n"

printf "Remember to use ctrl+z, not ctrl+c, to stop the script if needed.\n\n"

list=`curl -s https://dynasty-scans.com/series/$1 | $grep -o '(?<=href\=")[^"]*(?="\sclass\="name")'`

for chap in $list; do
	short=`echo $chap | $grep -o "(?<=$1_).*$"`
	echo $short

	if [ $check -eq 1 ]; then
		if [ "$short" = "$2" ]; then
			check=0
		else
			echo "Skipping"
			continue
		fi
	fi

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
