#!/bin/bash
# moves yt player 5 seconds forward
current_window=$(xdotool getwindowfocus)
target_window=$(xdotool search --onlyvisible --class "firefox" | head -n 1)
xdotool windowfocus "$target_window"
xdotool key --window "$target_window" Right
xdotool windowfocus "$current_window"
