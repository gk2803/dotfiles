#!/bin/bash
window="$1"
wid=""

# dum is in hex
for dum in $(bspc query -N -n .window); do
    if xprop -id "$dum" | grep -q "WM_CLASS(STRING) = .*"$window".*"; then
	wid="$dum"
	break
    fi
done 

# windowactivate takes arguments in decimal
# need to convert hex to dec
if [ -n "$wid" ]; then
    xdotool windowactivate $(("$wid"))
else
    if [ "$window" = "emacs" ]; then
	bash -ci 'emacsclient -c -a "emacs"'
    elif [ "$window" = "firefox" ]; then
	firefox
    elif [ "$window" = "Code" ]; then
	code
    elif [ "$window" = "terminal" ]; then
	xfce4-terminal
    fi
fi    

