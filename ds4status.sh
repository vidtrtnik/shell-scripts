#!/bin/bash

PSC="/sys/class/power_supply"

tput bold && tput setaf 7 && tput setab 4
echo
echo '--------------------------------'
echo '------ DUALSHOCK 4 STATUS ------'
echo -n '--------------------------------'

tput sgr0
echo

MAPA=$( find $PSC/sony_controller_battery_* 2>/dev/null )

if [ $? -eq 1 ]
then
	tput setaf 1
	echo "Napaka: ne najdem naprave DS4."
	exit 1
fi

tput setaf 6
echo $MAPA
echo
tput sgr0

echo
echo
echo

# ----------------------------------

while true
do


echo -ne "\033[A\r"
echo -ne "\033[A\r"
echo -ne "\033[A\r"

# STATUS
STATUS=$( cat $MAPA/status )
if [ "$STATUS" == "Charging" ]
then
	barvaPisave=3
else
	barvaPisave=2
fi

echo -n "Status: "
tput setaf $barvaPisave
echo $STATUS
tput sgr0
echo

KAPACITETA=$( cat $MAPA/capacity )

if [ "$KAPACITETA" -le 20 ]
then 
	barvaPisave=1
elif [ "$KAPACITETA" -le 80 ] && [ "$KAPACITETA" -gt 20 ]
then
	barvaPisave=3
else
	barvaPisave=2
fi

echo -n "Baterija: ["

for r in $( seq 1 10 ); do
	if [ $r -le $(( KAPACITETA/10 )) ]
	then
		tput setaf $barvaPisave
		echo -n "#"
	else
		echo -n " "
	fi
done
tput sgr0
echo -n "]-   "
tput setaf $barvaPisave
echo $KAPACITETA%
tput sgr0

read -t 3 -n 1 vnos
if [ "$vnos" ]
then
	if [ "$vnos" == "q" ]
	then
		echo
		exit 0
	fi
fi


done
