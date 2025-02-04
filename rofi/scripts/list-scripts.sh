#!/bin/bash

SCRIPTS_DIR=~/my-scripts/

# If no argument is provided, list all the scripts in the directory.
if [[ -z "$@" ]]; then
    find "$SCRIPTS_DIR" -maxdepth 1 -type f -executable -printf "%f\n"
else
    # Execute the selected script.
    "$SCRIPTS_DIR/$@"
fi
