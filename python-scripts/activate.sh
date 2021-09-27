#!/bin/bash
#
# Activates this virtual environment from any directory
# Must be ran with source command. i.e. `source ~/path/to/repo/python-scripts/activate`
# Run `deactivate` whenever you would like to deactivate the virtual environment
"""
slfklsl 
"""
# get path of this file
source="${BASH_SOURCE[0]:-$0}"
while [ -h "$source" ]; do # resolve $source until the file is no longer a symlink
 file_path="$( cd -P "$( dirname "$source" )" && pwd )"
 source="$(readlink "$source")"
 [[ $source != /* ]] && source="$file_path/$source" # if $source was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
file_path="$( cd -P "$( dirname "$source" )" && pwd )"

source "$file_path/.venv/bin/activate"