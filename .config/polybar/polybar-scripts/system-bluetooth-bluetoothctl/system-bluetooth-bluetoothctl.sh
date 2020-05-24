#!/bin/sh

bluetooth_print() {
    bluetoothctl | while read -r; do
        if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then

            if bluetoothctl show | grep -q "Powered: yes"; then
                devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
                counter=0

                echo "$devices_paired" | while read -r line; do
                    device_info=$(bluetoothctl info "$line")

                    if echo "$device_info" | grep -q "Connected: yes"; then
                        device_alias=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)
                        if [ $counter -gt 0 ]; then
                            counter=$((counter + 1))
                            printf ", %s" "$device_alias"
                        else
                            counter=$((counter + 1))
                            printf " %s" "$device_alias"
                        fi

                    fi
                done
                if [ $counter -eq 0 ]; then
                    echo " "
                fi
            else
                echo " %{F#888888}deactivated%{F-}"
            fi
        else
            echo " %{F#888888}off%{F-}"
        fi
    done
}

bluetooth_toggle() {
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        bluetooth_print
        ;;
    *)
        bluetooth_toggle
        bluetooth_print
        ;;
esac
