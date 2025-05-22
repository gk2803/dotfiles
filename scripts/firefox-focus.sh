#!/bin/bash

wid=""

# dum is in hex
for dum in $(bspc query -N -n .window); do
    if xprop -id "$dum" | grep -q "WM_CLASS(STRING) = .*firefox.*"; then
	wid="$dum"
	break
    fi
done 

# windowactivate takes arguments in decimal
# need to convert hex to dec
if [ -n "$wid" ]; then
    xdotool windowactivate $(("$wid"))
else
    firefox &
fi    

