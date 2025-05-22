#!/bin/bash
# moves yt player 5 seconds backward
current_window=$(xdotool getwindowfocus)
target_window=$(xdotool search --onlyvisible --class "firefox" | head -n 1)
xdotool windowfocus "$target_window"
xdotool key --window "$target_window" Left
xdotool windowfocus "$current_window"
