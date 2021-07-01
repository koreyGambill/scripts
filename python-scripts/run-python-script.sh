#!/bin/bash
#
# Runs a single python script from python-scripts in the virutal environment
set -eu

# get path of this file
source="${BASH_SOURCE[0]:-$0}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
 file_path="$( cd -P "$( dirname "$source" )" && pwd )"
 source="$(readlink "$source")"
 [[ $source != /* ]] && source="$file_path/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
file_path="$( cd -P "$( dirname "$source" )" && pwd )"
scripts_path="$file_path/scripts"

if [[ $# -eq 0 || $1 == "-h" || $1 == "--help" ]]; then
    echo -e "Usage: [script] [argument1] [argument2] [argument3] ... \n"
    echo -e "Available scripts: \n-----------------"
    IFS= # this preserves newlines in the following echo command
    echo $(ls -1 "$scripts_path" | grep --color=never "\.py")
    exit 0
fi

targetPythonScript="$1"
source "$file_path/env/bin/activate"
python3 "$scripts_path/$targetPythonScript" "${@:2}"