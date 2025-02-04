#!/bin/bash

if [ -z "$@" ]; then
    # No arguments passed, output the options
    echo -e "Shutdown\nReboot\nCancel"
else
    # An option was selected, handle it
    option="$@"
    case "$option" in
        "Shutdown")
            systemctl poweroff &
            ;;
        "Reboot")
            systemctl reboot &
            ;;
        "Cancel")
            # Do nothing, exit
            ;;
        *)
            # Invalid option
            echo "Invalid option" >&2
            ;;
    esac
    exit 0  # Ensure rofi closes after selection
fi
