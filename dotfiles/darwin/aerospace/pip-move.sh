#!/bin/bash
# # Get current workspace
current_workspace=$(aerospace list-workspaces --focused)

# Find all PiP window IDs and move them to the current workspace
for window_id in $(aerospace list-windows --all | awk '/Picture[- ]in[- ]Picture/ {print $1}'); do
    aerospace move-node-to-workspace --window-id "$window_id" "$current_workspace"
done
