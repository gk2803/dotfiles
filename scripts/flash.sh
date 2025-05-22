#!/bin/bash

echo "Set the keyboard in bootloader mode"
BEFORE=$(lsblk -n -o NAME)

while true; do
    AFTER=$(lsblk -n -o NAME)
    NEW_DEVICE=$(comm -13 <(echo "$BEFORE") <(echo "$AFTER"))
    
    if [ -n "$NEW_DEVICE" ]; then
        echo "USB device detected: /dev/$NEW_DEVICE"
        USB_PART=$(lsblk | grep 128M | grep part | awk '{print $1}' | tr -d '─')
	if [ -z "$USB_PART" ]; then
            echo "Error: Could not detect the correct partition."
            exit 1
        fi
	echo "Mounting /dev/$USB_PART to /mnt/usb"
	mkdir -p /mnt/usb
	if ! mount | grep -q "/mnt/usb"; then
	    mount /dev/$USB_PART /mnt/usb
	else
	    echo "USB already mounted."
	fi
	echo "Flashing keymap.."
	UF2_FILE=$(ls /home/rqd3/sources/qmk_firmware/*.uf2 2>/dev/null || true)

	if [ -z "$UF2_FILE" ]; then
	    echo "Error: No UF2 files found!"
	    exit 1
	fi
	cp "$UF2_FILE" /mnt/usb
	echo "Keymap flashed succesfully!"

	# unmount cleanly
	sleep 2
	umount /mnt/usb
	echo "USB unmounted. You can remove it safely."
	
        break
    fi
    sleep 1
done
