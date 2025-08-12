#!/bin/bash
aerospace layout floating &&
  osascript -e 'tell application "System Events" to key code 120 using {control down, option down, command down}' ||
  aerospace layout tiling
