#!/bin/bash

debug=false  # to activate debugging info in the console set to true, false otherwise
#nf will contain the number of arguments received from the nestjs web app (a single string containing the year month day separated with  spaces
nf="$(echo $1 | awk '{print NF}')"

if [  $# -ne 3 ] && [ $(($nf)) -ne 3 ]
then
     echo "Le script nécessite 3 arguments"
	exit 4
fi

echo "nb arg $#   nb arg from a single str $nf"


#case of a call of this script from cmdline  (eg.  ./set_date.sh 2023 10 23)
if [  $# -eq 3 ]
then

year="$1"
month="$2"
day="$3"

#echo "year month and day are set"
fi

#case of a call from the nestjs web app, (i.e all arguments (2023 10 23) are considered as a single parameter with white spaces as separator
if [ $(( $nf)) -eq 3 ]
then

year="$(echo $1 |awk '{print($1)}')"
month="$(echo $1 |awk '{print($2)}')"
day="$(echo $1 |awk '{print($3)}')"

fi


if [ $debug = true ]; then

     echo "Year: $year"
     echo  "Month: $month"
     echo "Day: $day"

fi


#echo "reached 1"
#if [ $(($month)) -lt 10  ]
#then
#     month="0$month"
#	
#fi

#if [ $(($day)) -lt 10 ]
#then
#     day="0$day"
#	
#fi


read y m d hour minute second< <(date +"%Y %m %d %H %M %S");


#where newdatetimestring has to follow the format nnddhhmmyyyy.ss which is described below:
#nn is a two digit month, between 01 to 12
#dd is a two digit day, between 01 and 31, with the regular rules for days according to month and year applying
#hh is two digit hour, using the 24-hour period so it is between 00 and 23
#mm is two digit minute, between 00 and 59
#yyyy is the year; it can be two digit or four digit: your choice. I prefer to use four digit years whenever I can for better clarity and less confusion
#ss is two digit seconds. Notice the period (.) before the ss.
#Let us say you want to set your computer s new time to December 6, 2007, 22:43:55, then you would use:

#echo "mois modifi $month";

timedatectl set-ntp false
if [ debug = true ]; then
     echo "we will set the date to:"
     echo "$month$day$hour$minute$year.$second"
fi

date "$month$day$hour$minute$year.$second"
hwclock -w

if [ $debug = true ]; then
     echo "RTC is set to"
     hwclock -r
fi



