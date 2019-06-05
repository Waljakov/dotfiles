#!/usr/bin/env bash

# Terminate already running bars
killall -q polybar

# Wait until processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar example &

echo "polybar launched..."

