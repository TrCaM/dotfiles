#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
  for sid in $(aerospace list-workspaces --all); do
    if [ "$sid" = "$FOCUSED_WORKSPACE" ]; then
      sketchybar --set space.$sid background.color=$ACCENT_PRIMARY \
                             label.color=$BACKGROUND_1
    else
      sketchybar --set space.$sid background.color=$BACKGROUND_1 \
                             label.color=$ACCENT_PRIMARY
    fi
  done
fi
