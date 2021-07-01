# Description
scripts is a place to put utility scripts in various scripting language. It will hopefully serve as a cheatsheet and reference to best practices.

Remember that windows, even using WSL, may run bash scripts differently than a mac or linux machine. These scripts will be mostly written for mac or linux.  

# Alias
## How to Use
It's useful to create alias's in your .zshrc or .bashrc file to the scripts.  
For example, you can save this (stuff between the ticks) into the file to create an alias called "gitsync"  
`alias gitsync="bash ~/path/to/repo/bash-scripts/gitSync.sh"` - Calls the gitsync script from any directory.  
Note that you can execute this in your terminal `gitsync argument1 argument2`, and the arguments get passed into the script.  
You need to restart your terminal for the alias to be avaialable to run.  

## Some Useful Alias's

### Docker
`alias docksocat="sudo docker run -d -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:1234:1234 bobrik/socat TCP-LISTEN:1234,fork UNIX-CONNECT:/var/run/docker.sock"` - necessary on mac to run docker commands. Run once after restarting computer.  
`alias dock="cd ~/code/imp-portal-app/ && docker-compose down && docker-compose up -d"` -navigates to my docker file and runs docker in detached mode  
`alias stw="cd ~/code/imp-portal-app/ && docker-compose down"` - cleans up running docker containers  

### Other
`alias idea="bash ~/code/scripts/bash-scripts/startIntellij.sh"` - use like `idea ~/code/<project>` - opens the project in intellij (Mac Specific)  
