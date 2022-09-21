#!/usr/bin/env bash

MESSAGE="What do you want to do "${USER^}"?"
POWER=" Shutdown"
RESTART=" Reboot"
LOGOUT=" Log out"
LOCK="  Lock"
SUSPEND="鈴 Suspend"
RES=`echo "$LOCK|$LOGOUT|$SUSPEND|$RESTART|$POWER" | rofi -dmenu -p "$MESSAGE" -sep "|" -theme mario -monitor -1`
[ "$RES" = "$POWER" ] && systemctl poweroff
[ "$RES" = "$RESTART" ] && systemctl reboot
[ "$RES" = "$LOGOUT" ] && loginctl terminate-session ${XDG_SESSION_ID-}
[ "$RES" = "$LOCK" ] && sleep .1 && i3lock-fancy
[ "$RES" = "$SUSPEND" ] && systemctl suspend && i3lock-fancy
