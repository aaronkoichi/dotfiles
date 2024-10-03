#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

#if all your bars have ipc enabled, you can also use
# polybar-msg cmd quit
#
# launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log /tmp/polybar3.log
polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown
polybar bar3 2>&1 | tee -a /tmp/polybar3.log & disown

echo "Bars launched..."
