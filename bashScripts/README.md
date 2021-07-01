# bashScripts
bashScripts is a place to put small bash utilities, and to serve as a cheatsheet and reference to best practices.

# Cheat Sheet

## Template
Here's a template to drop into most new bash scripts
``` bash
#!/bin/bash
#
# Description

if [[ $1 == "-h" ]]; then
echo "
Purpose:
    Description
Usage: bash fileName [param1] [param2]
    param1    Description
    param2    Description" 
exit 0
fi

# Check number of arguments
if [[ $# -ne 2 ]]; then echo -e "Incorrect number of arguments\n    'use -h' to see options" && exit 1; fi

```