# ~/.bashrc

[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

PS1='[\u@\h \W]\$ '

bind -x '"\C-n":fastfetch'

DIR_CHOICES=(
  "$HOME"
  "$HOME/.config"
  "$HOME/.config/nvim"
  "$HOME/.config/hypr"
  "$HOME/.config/kitty"
  "$HOME/.config/waybar"
  "$HOME/.config/tmux"

  "$HOME/Downloads"

  "$HOME/Documents"
  "$HOME/Documents/VimThings"
  "$HOME/Documents/ToDo"
  "$HOME/Documents/Jobs"
  "$HOME/Documents/TheClutterDir"

  # ---- Projects ----
  "$HOME/Documents/Projects"
  "$HOME/Documents/Projects/AdventureRoster"
  "$HOME/Documents/Projects/AirshipDeliverySystem"
  "$HOME/Documents/Projects/ClassRegistrationSystem"
  "$HOME/Documents/Projects/GravitySim"
  "$HOME/Documents/Projects/ParticleStuff"
  "$HOME/Documents/Projects/LukesWebsite"
  "$HOME/Documents/Projects/MovieCollectionManager"
  "$HOME/Documents/Projects/PotionInventorySystem"
  "$HOME/Documents/Projects/QuizGarden"
  "$HOME/Documents/Projects/RailwayStationSystem"
  "$HOME/Documents/Projects/FetchMe"

  # ---- School ----
  "$HOME/Documents/School"
  "$HOME/Documents/School/Exe"
  "$HOME/Documents/School/History"
  "$HOME/Documents/School/English"
  "$HOME/Documents/School/CS2"
)

tmux_windowizer() {
    local session="saps"
    local picks d name i wid last_wid=""
    picks="$(printf '%s\n' "${DIR_CHOICES[@]}" | fzf --prompt='Grass does not grow down... choose your roots wisely -> ' --height=100% --multi)" || return
    [[ -n "$picks" ]] || return
    if ! tmux has-session -t "$session" 2>/dev/null; then
        read -r d <<<"$picks"
        [[ -d "$d" ]] || return
        name="$(basename "$d" | tr -c 'A-Za-z0-9_-' '_' )"
        tmux new-session -ds "$session" -c "$d" -n "$name"
        picks="$(printf '%s\n' "$picks" | sed '1d')"
    fi
    while IFS= read -r d; do
        [[ -n "$d" && -d "$d" ]] || continue
        name="$(basename "$d" | tr -c 'A-Za-z0-9_-' '_' )"
        if tmux list-windows -t "$session" -F '#W' 2>/dev/null | grep -qx "$name"; then
            i=1
            while tmux list-windows -t "$session" -F '#W' | grep -qx "${name}-${i}"; do ((i++)); done
            name="${name}-${i}"
        fi
        wid="$(tmux new-window -t "$session" -c "$d" -n "$name" -P -F '#{window_id}')"
        last_wid="$wid"
    done <<<"$picks"
    [[ -n "$last_wid" ]] && tmux select-window -t "$last_wid"
    if [[ -n "${TMUX-}" ]]; then tmux switch-client -t "$session"; else tmux attach -t "$session"; fi
}

tmux_kill_all() {
    echo "Oh no... He's *ghasps dramiticly* dead"
    echo "Tmux has been slain"
    tmux kill-server
}

cd_windowizer() {
    local picks dir last_dir
    picks="$(printf '%s\n' "${DIR_CHOICES[@]}" | fzf --prompt='Grass only grows in one direction... choose your roots wisely -> ' --height=100% --multi)" || return
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

bind -x '"\C-g":tmux_windowizer'
bind '"\C-f":"\C-ucd_windowizer\C-m"'
bind -r '\C-t'
bind -x '"\C-tk":tmux_kill_all'

update() {
    sudo pacman -Syu --noconfirm
    yay -Syu --noconfirm
}
