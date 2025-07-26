#!/bin/bash
query=$(wofi -dmenu -p "Search")
if [[ -n "$query" ]]; then
    zen-browser "https://www.google.com/search?q=$query"
    hyprctl dispatch focuswindow "zen-browser"
fi
