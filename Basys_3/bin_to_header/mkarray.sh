#!/usr/bin/bash



if [ "$1" == "" ]   
then
    echo "Please input file(s) to convert"
    exit
else
#Remove any headerfiles from a previous operation
echo "Removing residual header files"
rm *.h
#Convert any bitfile to a corresponding C/C++ header file

xxd -i  $1 > "array_header.h"

echo "Successfully generated array header file"
fi
