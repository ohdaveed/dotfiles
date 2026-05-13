#!/usr/bin/env bash
# Claude Code status line — mirrors easy-term.omp.json segments

input=$(cat)

# --- Directory ---
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
# Shorten home prefix
cwd_display="${cwd/#$HOME/~}"

# --- Git branch + dirty flag ---
git_part=""
if git_branch=$(git -C "$cwd" --no-optional-locks rev-parse --abbrev-ref HEAD 2>/dev/null); then
    git_dirty=""
    if ! git -C "$cwd" --no-optional-locks diff --quiet 2>/dev/null || \
       ! git -C "$cwd" --no-optional-locks diff --cached --quiet 2>/dev/null; then
        git_dirty="*"
    fi
    git_part=" | ${git_branch}${git_dirty}"
fi

# --- Model ---
model=$(echo "$input" | jq -r '.model.display_name // ""')

# --- Context usage ---
ctx_part=""
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
if [ -n "$used_pct" ]; then
    ctx_part=" | ctx:$(printf '%.0f' "$used_pct")%"
fi

# --- Effort ---
effort_part=""
effort=$(echo "$input" | jq -r '.effort.level // empty')
if [ -n "$effort" ]; then
    effort_part=" | effort:${effort}"
fi

# --- Rate limits ---
rate_part=""
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
if [ -n "$five" ]; then
    rate_part=" | 5h:$(printf '%.0f' "$five")%"
fi

printf "%s%s | %s%s%s%s" \
    "$cwd_display" \
    "$git_part" \
    "$model" \
    "$ctx_part" \
    "$effort_part" \
    "$rate_part"
