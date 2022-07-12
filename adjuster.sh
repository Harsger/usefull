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

echo " filename   : "${filename}
echo " adjustment : "${adjustment}
echo " optONE     : "${optONE}
echo " moreOpts   : "${moreOpts}

command=""

if [[   "${adjustment}" == "ADDAFTER"  ]]; then
    command="sed -i '/^""${optONE}""/ a ""${moreOpts}"" ' ""${filename}"
elif [[ "${adjustment}" == "ADDBEFORE" ]]; then
    command="sed -i '/^""${optONE}""/ i ""${moreOpts}"" ' ""${filename}"
elif [[ "${adjustment}" == "DELETE"    ]]; then
    command="sed -i '/^""${optONE}""/ d' ""${filename}"
elif [[ "${adjustment}" == "REPLACE"   ]]; then
    command="sed -i 's/^""${optONE}""/""${moreOpts}""/' ""${filename}"
elif [[ "${adjustment}" == "SET"       ]]; then
    command="sed -i 's/^\(""${optONE}""[ \t]*\).*$/\1""${moreOpts}""/' ""${filename}"
fi

echo " command : ""${command}"
if [[ "${command}" != "" ]]; then
    eval "${command}"
fi 
