# Author: Credit to pypi.org for almost all of this
#
# Previews files in current directory in command line

import os
from simple_term_menu import TerminalMenu

def list_files(directory="."):
    return (file for file in os.listdir(directory) if os.path.isfile(os.path.join(directory, file)))

def main():
    terminal_menu = TerminalMenu(list_files(), preview_command="cat {}", preview_size=0.75)
    menu_entry_index = terminal_menu.show()

if __name__ == "__main__":
    main()