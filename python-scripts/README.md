# python-scripts
python-scripts is a place to put small python utilities to run from a venv, and to serve as a cheatsheet and reference to best practices.

# Mac Setup

## Set up Virtual Environment
Change into the python-scripts directory and run `python3 -m venv ./env` which will create a virtual environment where you can do you python scripting. `If doing a larger project or you are worried about conflicting modules, I suggest putting it in a separate folder with a separately instantiated venv.  

## Using Python Scripts
You can run the python scripts without being in a virtual environment, but you would have to install any necessary modules. It's recommended you install modules only in the virtual environments.  

To install modules in the virtual environment  
`source activate.sh`  
`python3 -m pip install <module>`  - note that you can use without python3 -m, but it's a best practice to be safe.  
`python3 -m pip freeze > requirements.txt` - saves everything you have installed in your virtual environment to a requirements file that people can then use for easy install  
`python3 -m pip install -r requirements.txt` - to install everything from requirements.txt  
`python3 -m pip install --upgrade -r requirements.txt` - to change package versions to match everything from requirements.txt  
`python3 -m pip install --upgrade -r requirements.txt` - to change package versions to match everything from requirements.txt  
`python3 -m pip list -o | grep -v 'Package' | grep -v '.*------.*' | awk '{print $1}' | xargs -L1 python3 -m pip install -U` - Upgrades all contents of requirements file one by one. After, you should do another pip freeze.  


To run python scripts after installing necessary modules run  
`source activate.sh` to start the virtual environment, then  
`python3 <pythonScript> <arguments>`  
`deactivate` to deactivate from the virtual environment  

Helper script to run a single python script from the virtual environment  
`bash path/to/run-python-script.sh <pythonScriptName> <arguments>`  

## Aliasing
It would be useful to create alias' similar to these (adjust the path to fit your directory structure)  
`alias py="$HOME/code/scripts/python-scripts/run-python-script.sh"` - runs a python script from the python-scripts directory  
`alias pyActivate="$HOME/code/scripts/python-scripts/activate.sh"` - Would allow you to run other python scripts in any directory  

## Grant Permissions
In order to use the alias' you also need to grant permissions.  
You can do this with  
`chmod 744 run-python-script.sh`  
`chmod 744 activate.sh`  

# Cheat Sheet

## Quickstart
`source ./env/bin/activate.sh` - activates virtual environment. Do this before running scripts.   
`python3 -m pip install <module>` - install modules to venv the safest way  
`python3 <python_script>` - run python script with python3. Runs in venv if venv is activated.  