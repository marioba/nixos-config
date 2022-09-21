#!/usr/bin/env bash

MESSAGE="Which Autorandr configuration do you want?"
HOME_CONF=" Home"
MOBILE_CONF="  Mobile"
RES=`echo "$HOME_CONF|$MOBILE_CONF" | rofi -dmenu -p "$MESSAGE" -sep "|" -theme mario -monitor -1`
[ "$RES" = "$HOME_CONF" ] && autorandr -l home
[ "$RES" = "$MOBILE_CONF" ] && autorandr -l mobile
