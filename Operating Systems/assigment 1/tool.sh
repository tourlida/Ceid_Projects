#!/bin/bash

#==============================================================================================================================

#AT 1st,3rd,5th,7th  elif statements we run our if with normal arguments

#AT 2nd,4th,6th elif statements we run our if by changing position to our arguments

#In every Stage that we need to do a search about something we make a use of GREP (searching command) with the right arguments

#we make use of sort in order to sort the fields that we want to print and by using the uniq command we keep only the different ones

#we also make use of awk in order to see the file as a seperated file with | as a seperator 

#This help us to make our print easier

#at 2nd,3rd,4th,5th questions we work in the same way in order to find and print what we asked about

#================================================================================================================================

if [[ "-f" == "$1" && -f "$2" && "-id" == "$3" ]]; then 
 
cat "$2" | grep "$4" |  awk -F'[(|)]' '{print $3, $2, $5}'
 
elif [[ "-id" == "$1" &&  "-f" == "$3" && -f "$4"  ]]; then

 cat "$4" | grep "$2" |  awk -F'[(|)]' '{print $3, $2, $5}'
 
elif [[ "--lastnames" == "$1" &&  "-f" == "$2" &&  -f "$3"  ]]; then

  cat "$3" | awk -F'[(|)]' '{print $3}' | sort -u
 
elif [[ "-f" == "$1" && "--lastnames" == "$3" && -f "$2" ]]; then

  cat  "$2" | awk -F '|' '{print $3}' | sort -u

elif [[ "--firstnames" == "$1" &&  "-f" == "$2" &&  -f "$3"  ]]; then

  cat  "$3" | awk -F '|' '{print $2}' | sort -u

elif [[ "-f" == "$1" && "--firstnames" == "$3" && -f "$2" ]]; then

  cat  "$2" | awk -F '|' '{print $2}' | sort -u

elif [[ "--browsers" == "$1" &&  "-f" == "$2" &&  -f "$3"  ]]; then
  
   cat  "$3" | awk -F '|' '{print $8}' | sort | uniq -c | awk '{print $2, $1}'

elif [[ "-f" == "$1" && "--browsers" == "$3" && -f "$2" ]]; then

  cat  "$2"  | awk -F '|' '{print $8}' | sort | uniq -c | awk '{print $2, $1}'


elif [[ "-f" == "$1" && (( -f "$2" ))  ]]; then 

cat "$2" 

else

#========================================
#if no argument is used we print our AM
#=======================================

 echo "AM 6233"

fi
