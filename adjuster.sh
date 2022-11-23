#!/bin/bash

usageOutput=" usage : ./`basename "$0"` FILENAME MODE OPTIONS "
usageOutput="${usageOutput}"" \n \t use MODE with OPTIONS : "
usageOutput="${usageOutput}"" \n \t \t ADDAFTER  > 'position' 'line to add' "
usageOutput="${usageOutput}"" \n \t \t ADDBEVORE > 'position' 'line to add' "
usageOutput="${usageOutput}"" \n \t \t DELETE    > 'identifier' "
usageOutput="${usageOutput}"" \n \t \t REPLACE   > 'phrase' 'replacement' "
usageOutput="${usageOutput}"" \n \t \t SET       > 'position' 'new arguments' "

if [[ $# -lt 3 ]]; then
    echo -e "${usageOutput}"
    exit 1
fi

filename="$1"
adjustment="$2"
optONE="$3"
moreOpts=""

if [[ $# -gt 3 ]]; then
    moreOpts="${moreOpts}""$4"
    for (( a=5; a<=$#; a++ )); do
        moreOpts="${moreOpts}"" ""${!a}"
    done
fi

toExecute=true

if [[ "${adjustment}" == "-"* ]]; then
    toExecute=false
    adjustment=${adjustment/-}
fi

command=""

if [[   "${adjustment}" == "ADDAFTER"  ]]; then
    command="sed -i '/^""${optONE}""/ a ""${moreOpts}"" ' ""${filename}"
elif [[ "${adjustment}" == "ADDBEFORE" ]]; then
    command="sed -i '/^""${optONE}""/ i ""${moreOpts}"" ' ""${filename}"
elif [[ "${adjustment}" == "DELETE"    ]]; then
    command="sed -i '/^""${optONE}""/ d' ""${filename}"
elif [[ "${adjustment}" == "REPLACE"   ]]; then
    command="sed -i 's/""${optONE}""/""${moreOpts}""/g' ""${filename}"
elif [[ "${adjustment}" == "SET"       ]]; then
    command="sed -i 's/^\(""${optONE}""[ \t]*\).*$/\1""${moreOpts}""/' ""${filename}"
else
    echo -e "${usageOutput}"
    exit 2
fi

if [ "${toExecute}" = true ]; then
    eval "${command}"
else
    echo " ""${command}"
fi 
