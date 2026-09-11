#!/bin/bash

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name')
dir=$(echo "$input" | jq -r '.workspace.current_dir')
display_dir="${dir/#$HOME/~}"

# ANSI colors (standard 8-color codes: readable on both light and dark backgrounds)
RESET="\033[0m"
DIM_SEP="\033[2m"
C_MODEL="\033[36m"   # cyan
C_DIR="\033[34m"     # blue
C_GIT_CLEAN="\033[32m"  # green
C_GIT_DIRTY="\033[33m"  # yellow
C_CTX_LOW="\033[32m"    # green
C_CTX_MED="\033[33m"    # yellow
C_CTX_HIGH="\033[31m"   # red

SEP="${DIM_SEP} | ${RESET}"

# Git branch/status (skip optional locks so this never blocks on a concurrent git process)
git_info=""
if git --no-optional-locks -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git --no-optional-locks -C "$dir" branch --show-current 2>/dev/null)
    if [ -z "$branch" ]; then
        branch=$(git --no-optional-locks -C "$dir" rev-parse --short HEAD 2>/dev/null)
    fi
    if [ -n "$branch" ]; then
        git_color="$C_GIT_CLEAN"
        dirty=""
        if [ -n "$(git --no-optional-locks -C "$dir" status --porcelain 2>/dev/null)" ]; then
            dirty="*"
            git_color="$C_GIT_DIRTY"
        fi
        git_info="${SEP}${git_color}${branch}${dirty}${RESET}"
    fi
fi

# Context window usage, colored by how much has been used
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
context_info=""
if [ -n "$used_pct" ]; then
    pct_rounded=$(printf '%.0f' "$used_pct")
    ctx_color="$C_CTX_LOW"
    [ "$pct_rounded" -ge 50 ] && ctx_color="$C_CTX_MED"
    [ "$pct_rounded" -ge 80 ] && ctx_color="$C_CTX_HIGH"
    context_info="${SEP}${ctx_color}Ctx: ${pct_rounded}%${RESET}"
fi

printf "${C_MODEL}%s${RESET} ${DIM_SEP}in${RESET} ${C_DIR}%s${RESET}%b%b" "$model" "$display_dir" "$git_info" "$context_info"
