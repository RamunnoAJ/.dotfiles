#!/usr/bin/env bash
set -euo pipefail

# ---- CONFIG ----
PROJ_A="$HOME/work/socialboost-front/"
PROJ_B="$HOME/work/socialboost-back/"

A_WIN0_CMD="vim ."
A_WIN1_CMD="npm run dev"

B_WIN0_CMD="vim ."
B_WIN1_CMD="npm run start:dev"
# ---------------

ensure_dir() {
  local d="$1"
  [[ -d "$d" ]] && printf '%s\n' "$d" || printf '%s\n' "$HOME"
}

create_if_missing () {
  local session="$1"
  local dir="$2"
  local win0_name="$3"
  local win0_cmd="$4"
  local win1_name="$5"
  local win1_cmd="$6"
  local win2_name="${7-}"     # opcional
  local win2_cmd="${8-}"      # opcional

  if ! tmux has-session -t "$session" 2>/dev/null; then
    dir="$(ensure_dir "$dir")"

    # ventana 0
    local win0_id
    win0_id="$(tmux new-session -d -s "$session" -n "$win0_name" -c "$dir" -P -F "#{window_id}")"
    [[ -n "$win0_cmd" ]] && tmux send-keys -t "$win0_id" "$win0_cmd" C-m

    # ventana 1 (append sin index explícito)
    local win1_id
    win1_id="$(tmux new-window -t "$session:" -n "$win1_name" -c "$dir" -P -F "#{window_id}")"
    [[ -n "$win1_cmd" ]] && tmux send-keys -t "$win1_id" "$win1_cmd" C-m

    # ventana 2 opcional
    if [[ -n "${win2_name}" ]]; then
      local win2_id
      win2_id="$(tmux new-window -t "$session:" -n "$win2_name" -c "$dir" -P -F "#{window_id}")"
      [[ -n "${win2_cmd}" ]] && tmux send-keys -t "$win2_id" "$win2_cmd" C-m
    fi

    # volver a la primera ventana creada (por id, inmune a renumeración)
    tmux select-window -t "$win0_id"
  fi
}

# Sesión front
create_if_missing \
  "front" "$PROJ_A" \
  "vim"   "$A_WIN0_CMD" \
  "npm"   "$A_WIN1_CMD"

# Sesión back
create_if_missing \
  "back" "$PROJ_B" \
  "vim"  "$B_WIN0_CMD" \
  "npm"  "$B_WIN1_CMD"

# Adjuntar si estás fuera de tmux; si no, mostrás mensaje
if [[ -z "${TMUX:-}" ]]; then
  tmux attach -t front || tmux attach
else
  tmux display-message "Sesiones 'front' y 'back' listas"
fi
