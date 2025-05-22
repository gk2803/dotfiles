#!/bin/bash

# Save current window
current_window=$(xdotool getwindowfocus)

# Find Chromium or Firefox
target_window=$(xdotool search --onlyvisible --class "firefox" | head -n 1)

# Send key to browser without staying on it
xdotool windowfocus "$target_window"
xdotool key --window "$target_window" space

# Go back to previous window
xdotool windowfocus "$current_window"

