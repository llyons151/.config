# ~/.bashrc

[[ $- != *i* ]] && return

alias ls='ls -g --color=auto'
alias grep='grep --color=auto'

PS1='[\u@\h \W]\$ '

bind -x '"\C-n":fastfetch'

# Specific dirs listed individually
EXTRA_DIRS=(
  "$HOME"
  "$HOME/.config"
  "$HOME/.config/nvim"
  "$HOME/.config/hypr"
  "$HOME/.config/kitty"
  "$HOME/.config/waybar"
  "$HOME/.config/wofi"
  "$HOME/.config/herdr"

  "$HOME/Downloads"

  "$HOME/Pictures"
  "$HOME/Pictures/wallpapers"

  "$HOME/Documents"
)

# Parent dirs — their immediate (non-hidden) children are auto-included
PARENT_DIRS=(
  "$HOME/Documents"
  "$HOME/Documents/SelfStudy"
  "$HOME/Documents/Projects"
  "$HOME/Documents/School"
)

_build_dir_choices() {
  DIR_CHOICES=("${EXTRA_DIRS[@]}")
  local parent child
  for parent in "${PARENT_DIRS[@]}"; do
    [[ -d "$parent" ]] || continue
    DIR_CHOICES+=("$parent")
    for child in "$parent"/*/; do
      [[ -d "$child" ]] || continue
      DIR_CHOICES+=("${child%/}")
    done
  done
}

herdr_windowizer() {
    local picks d name i last
    _build_dir_choices
    picks="$(printf '%s\n' "${DIR_CHOICES[@]}" | fzf --prompt='Clocks only tick in one direction: ' --height=100% --multi)" || return
    [[ -n "$picks" ]] || return

    # Make sure the persistent herdr server is up (no-op if already running).
    herdr status server >/dev/null 2>&1 || { herdr server >/dev/null 2>&1 & disown; sleep 0.3; }

    # Collect the valid directory picks.
    local -a dirs=()
    while IFS= read -r d; do
        [[ -n "$d" && -d "$d" ]] && dirs+=("$d")
    done <<<"$picks"
    [[ ${#dirs[@]} -gt 0 ]] || return

    # One tab per pick (switchable with Alt+1..9); focus the last one created.
    last=$(( ${#dirs[@]} - 1 ))
    for i in "${!dirs[@]}"; do
        d="${dirs[$i]}"
        name="$(basename "$d")"; name="${name//[^A-Za-z0-9_-]/_}"
        if (( i == last )); then
            herdr tab create --cwd "$d" --label "$name" --focus   >/dev/null 2>&1
        else
            herdr tab create --cwd "$d" --label "$name" --no-focus >/dev/null 2>&1
        fi
    done

    # If we're running outside herdr, attach to the session now.
    [[ -z "${HERDR_PANE_ID-}" ]] && herdr
}

herdr_kill_all() {
    echo "Oh no... He's *ghasps dramiticly* dead"
    echo "The herd has been scattered"
    herdr server stop
}

cd_windowizer() {
    local picks dir last_dir
    _build_dir_choices
    picks="$(printf '%s\n' "${DIR_CHOICES[@]}" | fzf --prompt='Clocks only tick in one direction: ' --height=100% --multi)" || return
    [[ -n "$picks" ]] || return
    while IFS= read -r dir; do
        [[ -d "$dir" ]] || continue
        last_dir="$dir"
    done <<<"$picks"
    [[ -n "$last_dir" ]] || return
    echo "→ cd to: $last_dir"
    builtin cd -- "$last_dir" || return
    ls -gA
}

bind -x '"\C-g":herdr_windowizer'
bind '"\C-f":"\C-ucd_windowizer\C-m"'
bind -r '\C-t'
bind -x '"\C-tk":herdr_kill_all'

update() {
    sudo pacman -Syu --noconfirm
    yay -Syu --noconfirm
}
kitty_black() {
    kitty @ set-background-opacity 1.0
}
kitty_toggle_opacity() {
    if [[ "$KITTY_OPACITY" == "opaque" ]]; then
        kitty @ set-background-opacity 0.7
        export KITTY_OPACITY=transparent
    else
        kitty @ set-background-opacity 1.0
        export KITTY_OPACITY=opaque
    fi
}

export LANG=en_US.UTF-8
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
