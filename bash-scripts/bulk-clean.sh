#!/bin/bash
#
# Cleans out your project's node_modules and I think target folder on maven

cd ~/code/

for item in `ls`; do
    if [[ -d $item ]]; then
        cd $item
        if [[ -d node_modules ]]; then
            echo "rm -rf $item/node_modules/"
            rm -rf node_modules/
        fi
        if [[ -e pom.xml ]]; then
            echo "Maven Clean on $item"
            mvn -q clean
        fi
        cd ..
    fi
done