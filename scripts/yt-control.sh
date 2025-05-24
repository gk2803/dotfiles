#!/bin/bash
arg=$1
# moves yt player 5 seconds backward
current_window=$(xdotool getwindowfocus)
target_window=$(xdotool search --onlyvisible --class "firefox" | head -n 1)
xdotool windowfocus "$target_window"
xdotool key --window "$target_window" "$arg"
xdotool windowfocus "$current_window"
