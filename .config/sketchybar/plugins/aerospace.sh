#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$NAME" = "space.$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.color=$ACCENT_PRIMARY \
                         label.color=$BACKGROUND_1
else
  sketchybar --set $NAME background.color=$BACKGROUND_1 \
                         label.color=$ACCENT_PRIMARY
fi
