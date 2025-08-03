#!/bin/sh

#SPACE_ICONS=("1" "2" "3" "4")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sketchybar --add event aerospace_workspace_change

for sid in $(aerospace list-workspaces --all); do
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
    icon="$sid" \
    icon.highlight_color=$RED \
    icon.padding_left=10 \
    icon.padding_right=10 \
    display=$m \
    padding_left=2 \
    padding_right=2 \
    label.drawing=off \
    background.color=$BACKGROUND_1 \
    click_script="aerospace workspace $sid" \
    script="$CONFIG_DIR/plugins/aerospace.sh $sid"
done
