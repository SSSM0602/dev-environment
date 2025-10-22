#!/bin/bash

PROJECTS_DIR="$HOME/projects"

for dir in "$PROJECTS_DIR"/*/; do
    [ -d "$dir" ] || continue  # skip if not a directory
    session_name=$(basename "$dir")

    # Don’t recreate if it already exists
    tmux has-session -t "$session_name" 2>/dev/null
    if [ $? != 0 ]; then
        # Create detached session in project directory
        tmux new-session -d -s "$session_name" -c "$dir"

        # First window: open editor
        tmux send-keys -t "$session_name" "nvim" C-m
    fi
done

# Attach to the first session created
tmux attach -t "$(basename "$(ls -d "$PROJECTS_DIR"/*/ | head -n 1)")"

