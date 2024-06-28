#!/bin/sh

run() {
	if ! pgrep -f "$1"; then
		"$@" &
	fi
}

xset s off
xset -dpms
xset s noblank


run picom
run setxkbmap -layout us,ru -option grp:alt_shift_toggle
run xrandr --setprovideroffloadsink 1 0
run eval $(gnome-keyring-daemon --start) && /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# run telegram-desktop
# run discord --start-minimized
# run firefox
