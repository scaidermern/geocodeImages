#!/bin/sh
#
# Copyright (C) 2010 Alexander Heinlein
# Copyright (C) 2012 Elwell
#
# adds given coordinates in lat and lon to the images EXIF header
#
# This program is free software blah GNU GPL version 3+ blah.
# 
 
set -e
 
decimal_to_sexagesimal()
{
    # just multiply decimal by 60
    degrees=$(echo "$1" | cut -d "." -f1)
    if [ $degrees -lt 0 ]; then
        degrees=$(echo $degrees | cut -c2- )
    fi
    minute=$(echo "$1" | cut -d "." -f2)
    minute=$(echo "0.$minute * 60" | bc -l)
    seconds=$(echo "$minute" | cut -d "." -f2)
    # multiply seconds by large value because exiv2 does not accept decimal values, but fractions
    seconds=$(echo "0.$seconds * 60 * 100" | bc -l | cut -d "." -f1)
    # remove decimal from minute and seconds, was needed before to calculate seconds
    minute=$(echo $minute | cut -d "." -f1)
 
    echo "$degrees/1 $minute/1 $seconds/100"
}
 
for program in cut bc exiv2
do
    if ! $(which $program >/dev/null)
    then
        echo "please install $program"
        exit 1
    fi
done
 
if [ "$#" -ne "3" ]
then
    echo "usage: $0 lat lon image.jpg"
    echo "       where lat and lon are in decimal"
    exit 1
fi
if [ $(echo "$1" | cut -d "." -f1) -gt 0 ] ; then
    LatRef="set Exif.GPSInfo.GPSLatitudeRef N"
else
    LatRef="set Exif.GPSInfo.GPSLatitudeRef S"
fi
if [ $(echo "$2" | cut -d "." -f1) -gt 0 ] ; then
    LonRef="set Exif.GPSInfo.GPSLongitudeRef E"
else
    LonRef="set Exif.GPSInfo.GPSLongitudeRef W"
fi
 
lat=$(decimal_to_sexagesimal $1)
lon=$(decimal_to_sexagesimal $2)
 
echo "setting lat $lat and lon $lon for image $3"
exiv2 -v -k -M"set Exif.GPSInfo.GPSLatitude $lat"  -M"$LatRef" \
            -M"set Exif.GPSInfo.GPSLongitude $lon" -M"$LonRef" $3
