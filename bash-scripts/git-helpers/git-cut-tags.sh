#!/bin/bash/sh

###### Set up Guide ######
# 1) Paste this file into a folder, and save it with the .sh extension
# 2) Give permissions to execute it - Linux/Mac you can do `chmod 700 <filename>`
# 3) Optionally, create an alias like
#	alias git-cut-tags="bash ~/path/to/scripts/bash-scripts/git-cut-tags.sh"
# 4) 'git-cut-tags -c for configuration information'
# 5) 'git-cut-tags -h for help'

###### Notes ######
# I would like to make the version optional at some point, but I have to extract it from the project.


if [[ $1 == "-h" ]];
then
    echo "
Configure: 'git-cut-tags -c' for configuration information

Purpose:
    Run this script after merging code to integration

    First it creates a release branch
        then it makes a commit if necessary to change the version of the project
        then it creates a tag and pushes it to stash
        then it pushes the release branch, and creates a pull request to Master

    Your code should then be building through a release branch pipeline
        and deploying to staging after this is ran

Usage: git-cut-tags [project-name] [branch-name] [tag-version]

    project-name    Match the repo name in stash
                    Match local folder name for the project
                    Example: historical-data-web

    branch-name     release/<JIRAPROJECT>-<caseNumber>-<description>
                    Example: release/COOLQUEUE-1234-my-cool-feature
                    Checks out a branch with that name
    
    tag-version     The version that you want to be tagged
                    Example: 2.4.0
                    The code will update the package-lock.json 
                        and package.json files if necessary 
                        to match that version
                    
    "
    exit 0
fi

if [[ $1 == "-c" ]];
then
    echo "
Necessary Installations:
git
    refer to Developer Machine Setup guide in confluence
    'git config --global user.name \"John Doe\"'
    'git config --global user.email johndoe@example.com'

npm
    for frontend projects
    refer to Developer Machine Setup guide in confluence
    usually installed through node like 'sudo apt install nodejs'

mvn
    for backend projects
    refer to Developer Machine Setup guide in confluence

ruby
    may already by installed, otherwise 'sudo apt install ruby'

stash
    'gem install atlassian-stash'
        gem is made available through ruby
    'stash configure' - to configure things like your 
        username and password to stash

File Configurations:
1) You should have a folder where all of your git projects reside.
    Such as ~/code/<gitprojects>
    And you should change this line in the script 
        cd ~/code/\$project_name || exit
    to reflect that path
2) Clone the project locally.
3) You should change the reviewers at the end of this file 
    to match the reviewers you want in stash
"
    exit 0
fi


if [[ $# -ne 3 ]];
then
    echo "
Incorrect number of arguments
    'git-cut-tags -h' to see options
    'git-cut-tags -c' to see necessary configuration
"
    exit 1
fi

project_name=$1
branch_name=$2 # release/jiraProject-caseNumber-description
version_number=$3

cd ~/code/$project_name || exit 1
# hardcoded for npm & mvn, but we can add more in the future if we need to - like python
if [[ -f "package.json" ]];
then
    is_npm_project="true"
else
    is_npm_project="false"
fi

echo

if [[ $branch_name =~ ^release\/[A-Z]+\-[0-9]+\-.+$ ]];
then
    # Pull out the Project-Casenumber portion for the commit message
    project_and_case_and_description="${branch_name##*/}" # jiraProject-caseNumber-description
    case_and_description="${project_and_case_and_description#*-}" # caseNumber-description
    description="${case_and_description#*-}" # description
    project_and_case="${project_and_case_and_description%-${description}}" # jiraProject-caseNumber
else
    echo "
Branch name not accepted: '$branch_name'
Should be in form: release/<JIRAPROJECT>-<caseNumber>-<description>"
    exit 1
fi

if ! [[ $version_number =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]];
then
    echo "version name $version_number not accepted. Should be in form major.minor.tag"
    exit 1
fi

set -x #echo on
git fetch && git fetch -t
git checkout integration
git pull
git checkout -b $branch_name || git checkout $branch_name
git merge integration # In case branch was already created
# TODO: check for merge conflicts before trying rest of script
if [[ $is_npm_project == "true" ]]; then
    npm --no-git-tag-version version $version_number
else
    mvn versions:set -DgenerateBackupPoms=false -DnewVersion=$version_number
fi
git commit -am "$project_and_case: bumping versions after release"
if [ $? -ne 0 ]; then
    echo "Commit failed! Exiting script"
    exit 1
fi
git tag -a -m "$description" "$project_name-$version_number"
if [ $? -ne 0 ]; then
    echo "Tagging with $project_name-$version_number failed. Check if it already exists."
    exit 1
fi
git push -u origin "$project_name-$version_number"
git push -u origin $branch_name
# reviewer_list="@username1 @username2
# stash pull-request $branch_name origin/master "$reviewer_list"