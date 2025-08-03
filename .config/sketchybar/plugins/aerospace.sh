#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

# Source color variables
source "$CONFIG_DIR/colors.sh"

# The script is called for each space item individually.
# $1 is the SID of the space this script is running for.
# $NAME is the name of the sketchybar item, e.g., space.1
#
# Aerospace provides the following environment variables:
# - FOCUSED_WORKSPACE: The name of the currently focused workspace.
# - PREV_WORKSPACE: The name of the previously focused workspace.

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  # Style for the active workspace
  sketchybar --set $NAME background.drawing=on \
    icon.color=$WHITE
elif [ "$1" = "$PREV_WORKSPACE" ]; then
  # Style for the last active workspace
  sketchybar --set $NAME background.drawing=on \
    background.color=$BACKGROUND_2 \
    icon.color=$LABEL_COLOR
else
  # Style for all other inactive workspaces
  sketchybar --set $NAME background.drawing=off \
    icon.color=$ICON_COLOR
fi
