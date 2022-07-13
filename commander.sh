#!/bin/bash

parameterfile=$1
debugOption=$2

if [[ ! -f ${parameterfile} ]]; then
    echo ' ERROR : "'${parameterfile}'" does not exist '
    exit 1
fi

declare -A parts
declare -a sequence
declare -a commandList

while read specifier arguments; do

    if [[ ${specifier} == '#'* ]] || [[ ${specifier} == '' ]]; then
        continue
    elif [[ ${specifier} == 'PART'* ]]; then
        parts[${specifier}]=${arguments}
    elif [[ ${specifier} == 'SEQUENCE' ]]; then
        read -ra words <<< ${arguments}
        for w in ${words[@]}; do
            sequence[${#sequence[@]}]=${w}
        done
    else
        commandList[${#commandList[@]}]=${specifier}' '${arguments}
    fi

done < ${parameterfile}

if [[ ${#commandList[@]} -lt 1 ]]; then
    echo ' ERROR : no command-list found '
    exit 2
fi

listEntry=( ${commandList[0]} )
nColumns=${#listEntry[@]}
for entry in ${!commandList[@]}; do
    listEntry=( ${commandList[${entry}]} )
    if [[ ${#listEntry[@]} -ne ${nColumns} ]]; then
        echo ' ERROR : command-list entries must have same number of columns '
        exit 3
    fi
done

for entry in ${sequence[@]}; do

    if [[ ${entry} == 'SPACE' ]]; then
        continue
    elif [[ ${entry} == 'PART'* ]]; then
        if [[ -z "${parts[${entry}]}" ]]; then
            echo ' ERROR : for sequence "'${entry}'" is not defined '
            exit 4
        fi
    elif [[ ${entry} == 'COLUMN'* ]]; then
        columnNumber=${entry/COLUMN}
        if [[ ${columnNumber} -ge ${nColumns} ]]; then
            echo ' ERROR : column-numbers specified in '
            echo '         sequence (#='${columnNumber}') '
            echo '         must be smaller than number of columns in '
            echo '         command-list (#='${nColumns}') '
            exit 5
        fi
    else
        echo ' ERROR : unknown parameter "'${entry}'" in sequence '
        exit 6
    fi
    
done

for entry in ${!commandList[@]}; do
    listEntry=( ${commandList[${entry}]} )
    nextCommand=''
    for item in ${sequence[@]}; do
        if [[ ${item} == 'SPACE' ]]; then
            nextCommand=${nextCommand}' '
        elif [[ ${item} == 'PART'* ]]; then
            nextCommand=${nextCommand}${parts[${item}]}
        elif [[ ${item} == 'COLUMN'* ]]; then
            columnNumber=${item/COLUMN}
            nextCommand=${nextCommand}${listEntry[${columnNumber}]}
        fi
    done
    if [[ ${debugOption} == 'execute' ]]; then
        eval ${nextCommand}
    elif [[ ${debugOption} == 'verbose' ]]; then
        echo ${nextCommand}
        eval ${nextCommand}
    else
        echo ${nextCommand}
    fi
done
