#!/bin/bash

#projectPath="/home/pi/sirene/v2"

debug=false  # to activate debugging info in the console set to true, false otherwise


echo $1
echo $2

#if test $# -lt 2
#then
#     echo "Le script nécessite 2 arguments au moins, nb arg passés: $#"
#	exit
#fi



nf="$(echo $1 | awk '{print NF}')"

if [  $# -ne 2 ] && [ $(($nf)) -ne 2 ]
then
     echo "Le script nécessite 2 arguments"
        exit 4
fi


#$projectPath/sir_log/generalLogger.sh "set_time" "begin" 
read year month day hour minute < <(date +"%Y %m %d %H %M");


if [  $# -eq 2 ]
then

hour="$1"
minute="$2"

fi

if [  $(($nf)) -eq 2 ]
then

hour=$(("$(echo $1 |awk '{print($1)}')"))
minute=$(("$(echo $1 |awk '{print($2)}')"))

fi

echo "hour $hour  minute $minute"

#hour="$1"
#minute="$2"




if [ $hour -lt 10 ]
then
     hour="0$hour"
	
fi

if [ $minute -lt 10 ]
then
     minute="0$minute"
	
fi
#where newdatetimestring has to follow the format nnddhhmmyyyy.ss which is described below:
#nn is a two digit month, between 01 to 12
#dd is a two digit day, between 01 and 31, with the regular rules for days according to month and year applying
#hh is two digit hour, using the 24-hour period so it is between 00 and 23
#mm is two digit minute, between 00 and 59
#yyyy is the year; it can be two digit or four digit: your choice. I prefer to use four digit years whenever I can for better clarity and less confusion
#ss is two digit seconds. Notice the period (.) before the ss.
#Let us say you want to set your computers new time to December 6, 2007, 22:43:55, then you would use:
if [ $debug = true ]; then
     echo "we will set the date to:"
     echo "$month$day$hour$minute$year.00"
fi
timedatectl set-ntp false

date "$month$day$hour$minute$year.00"
hwclock -w

if [ $debug = true ]; then
     echo "RTC is set to"
     hwclock -r
fi
