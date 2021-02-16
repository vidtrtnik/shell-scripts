#!/bin/bash
fname=$1
out=$2

echo "# IP filter" > $out
while IFS= read -r line; do
	ip1=$(echo $line | cut -d',' -f1 | tr -d "\"")
	ip2=$(echo $line | cut -d',' -f2 | tr -d "\"")
	#echo "$ip1"
	#echo "$ip2"
	echo "allow $(ipcalc "$ip1-$ip2" | sed -n 2p);" >> $out
done <"$fname"
echo "deny all;" >> $out