#!/bin/sh

###### Purpose ######
# Takes the jira case from your branch and prepends it to your commit message if necessary.

###### Warnings ######
# Local project hooks should override global, but they aren't for me.
# Either don't set your global path, or use the $GIT_DIR variable and edit the script to check local first.

###### Set up Guide ######

# For Local:
# Either paste this file into your local repo .git/hooks/ folder, or apply it globally
#
# For global:
# Run commands (in git bash, terminal, something linux based)
# `mkdir ~/git && mkdir ~/git/hooks/`
# `git config --global core.hooksPath ~/git/hooks/`
# Paste this file "prepare-commit-msg" into that folder
#
# It should be working
#
# Feel free to put it somewhere else
# If you want to see where your git config is currently
# `git config --list --show-origin`


###### The Script ######

# Expecting branch names like user/jiraProject-caseNumber-fixing-bug

BRANCH_NAME=$(git symbolic-ref --short HEAD) # user/jiraProject-caseNumber-fixing-bug

BRANCH_NAME_WITHOUT_USER="${BRANCH_NAME##*/}" # jiraProject-caseNumber-fixing-bug

STRIPPED_JIRA_PROJECT="${BRANCH_NAME_WITHOUT_USER#*-}" # caseNumber-fixing-bug

STRIPPED_CASE_NUMBER="${STRIPPED_JIRA_PROJECT#*-}" # fixing-bug

JIRA_CASE="${BRANCH_NAME_WITHOUT_USER%-${STRIPPED_CASE_NUMBER}}" # jiraProject-caseNumber

CASE_IN_COMMIT=$(grep -c "$JIRA_CASE" $1) # Checks to see if JIRA_CASE is already in the commit message

# If the case isn't already in the commit message, and the jira case was parsed correctly
# from the branch name then append the jira case to the commit message
if [[ $CASE_IN_COMMIT -lt 1 ]] && [[ -n "$JIRA_CASE" ]]; then
    echo "Prepending case number ${JIRA_CASE} to commit message"
    sed -i.bak -e "1s/^/$JIRA_CASE: /" $1
fi