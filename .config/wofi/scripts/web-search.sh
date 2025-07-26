#!/bin/bash
history_file="$HOME/.cache/wofi-search-history"

# Wczytaj historię lub utwórz pustą linię
if [[ -f "$history_file" ]]; then
    input=$(cat "$history_file")
else
    input=""
fi

query=$(echo -e "$input" | wofi --dmenu \
    --prompt "Search in browser" \
    --lines 5 \
    --cache-file /dev/null)

if [[ -n "$query" ]]; then
    # Dodaj do historii (unikalne wpisy)
    echo "$query" > /tmp/new_history
    if [[ -f "$history_file" ]]; then
        grep -v "^$query$" "$history_file" >> /tmp/new_history
    fi
    head -10 /tmp/new_history > "$history_file"
    rm /tmp/new_history
    
    # Otwórz przeglądarkę
    zen-browser "https://www.google.com/search?q=$query"
    hyprctl dispatch focuswindow "zen-browser"
fi
