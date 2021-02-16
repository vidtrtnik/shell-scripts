#!/bin/bash

while true;
do
	COM_CORES="$(grep -E '^model name' /proc/cpuinfo | cut -d':' -f2)"
	COM_FREQS="$(grep -E '^cpu MHz' /proc/cpuinfo | cut -d':' -f2)"
	COM_TEMPS="$(sensors | grep Core | cut -d'+' -f2 | cut -d' ' -f1)"
	CORES=()
	FREQS=()
	TEMPS=()

	while read line;
	do
		#echo $line
		CORES+=("$line")
	done <<< $COM_CORES

	while read line;
	do
		#echo $line
		FREQS+=("$line")
	done <<< $COM_FREQS

	while read line;
	do
		#echo $line
		TEMPS+=("$line")
	done <<< $COM_TEMPS

	# Print
	printf "CPU\t\t\t\t\t\tFREQ\t\tTEMPS\n\n"
	for (( i=0; i < ${#CORES[@]}; i++ ));
	do
		printf "${CORES[$i]}\t${FREQS[$i]} Mhz\t${TEMPS[(( $i / (( ${#CORES[@]} / 2 )) ))]}\t[$i]\n"
	done

read -t 3
clear
done
