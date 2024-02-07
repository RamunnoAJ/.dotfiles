#!/usr/bin/env bash

# Check if a session name was provided as an argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <session-name>"
  exit 1
fi

# Get the session name from the first argument
session_name="$1"

# Run tmux attach-session with the specified session name
tmux attach-session -t "$session_name"
