#!/usr/bin/env bash
# Apply pywal theming based on current wallpaper.
# Called by waypaper post_command, or manually with a path argument.

ARG="$1"
# Treat unset, empty, or literal "$wallpaper" as "read from config"
if [ -z "$ARG" ] || [[ "$ARG" == \$* ]]; then
  WALL="$(awk -F'[[:space:]]*=[[:space:]]*' '/^wallpaper[[:space:]]*=/ {print $2; exit}' "$HOME/.config/waypaper/config.ini")"
else
  WALL="$ARG"
fi
WALL="${WALL/#\~/$HOME}"

if [ ! -f "$WALL" ]; then
  echo "apply_wal: wallpaper not found: $WALL" >&2
  exit 1
fi

WAYBAR_COLORS="$HOME/.cache/wal/colors-waybar.css"

# pywal can exit non-zero on harmless ImageMagick deprecation warnings,
# and on truly monochromatic images (e.g. a solid black square) it can
# fail to extract any palette at all. We don't gate on its exit code —
# if it fails, we keep the previously cached palette so waybar still
# gets reloaded with whatever colors-waybar.css we last had.
wal -i "$WALL" -n -q -s -t 2>/dev/null || true

if [ ! -s "$WAYBAR_COLORS" ]; then
  echo "apply_wal: no $WAYBAR_COLORS available (pywal never produced one)" >&2
  exit 1
fi

# pywal's color5 is the accent. On near-monochrome wallpapers it comes
# out as a tinted grey (e.g. tan on a black image), which reads as
# "wrong color" rather than "subtle accent". When color5's HSV saturation
# is below 20%, fall back to color15 (bright foreground) everywhere we
# use the accent, so active highlights stay high-contrast.
COLOR5=$(sed -n '6p' "$HOME/.cache/wal/colors")
COLOR15=$(sed -n '16p' "$HOME/.cache/wal/colors")
hex=${COLOR5#\#}
r=$((16#${hex:0:2})); g=$((16#${hex:2:2})); b=$((16#${hex:4:2}))
max=$r; (( g > max )) && max=$g; (( b > max )) && max=$b
min=$r; (( g < min )) && min=$g; (( b < min )) && min=$b
sat=0
(( max > 0 )) && sat=$(( (max - min) * 100 / max ))
if (( sat < 20 )); then
  sed -i -E "s|(@define-color[[:space:]]+border_hi[[:space:]]+)$COLOR5;|\1$COLOR15;|" "$WAYBAR_COLORS"
  # Hyprland uses color5 (no #) inside rgba(...) for $col_active.
  sed -i -E "s|(\\\$col_active[[:space:]]*=[[:space:]]*rgba\()${COLOR5#\#}(ff\))|\1${COLOR15#\#}\2|" "$HOME/.cache/wal/colors-hypr.conf"
fi

if ! cat "$WAYBAR_COLORS" ~/.config/waybar/style.base.css > ~/.config/waybar/style.css; then
  echo "apply_wal: failed to write waybar style.css" >&2
  exit 1
fi

hyprctl reload >/dev/null 2>&1 || true

# focus_mode.sh sets gaps=0/border=0 via `hyprctl keyword`. `hyprctl reload`
# above wipes those overrides — re-apply them if focus mode is active so
# the bar/border state matches /tmp/hypr_focus_mode.
FOCUS_FILE="/tmp/hypr_focus_mode"
if [ -f "$FOCUS_FILE" ]; then
  hyprctl --batch "keyword general:gaps_in 0 ; keyword general:gaps_out 0 ; keyword general:border_size 0" >/dev/null 2>&1 || true
fi

# Hot-reload waybar in place; SIGUSR2 makes waybar re-read config and CSS
# without exiting, which avoids the race we used to hit with pkill+sleep+launch.
# If waybar isn't running yet (e.g. very early at login), launch it.
if ! pkill -USR2 -x waybar 2>/dev/null; then
  nohup waybar >/dev/null 2>&1 &
  disown
fi

# SIGUSR2 can flip waybar's visible state on some versions, leaving it out of
# sync with focus_mode.sh's state file. Use hyprctl's layer list (waybar shows
# up as a "waybar" namespace iff its layer surface is mapped) to detect actual
# visibility, then send USR1 (toggle) only if it disagrees with the state file.
sleep 0.1
waybar_mapped() { hyprctl layers -j 2>/dev/null | grep -q '"namespace": "waybar"'; }
if [ -f "$FOCUS_FILE" ]; then
  # Should be hidden. If currently visible, toggle once.
  waybar_mapped && pkill -USR1 -x waybar 2>/dev/null || true
else
  # Should be visible. If currently hidden, toggle once.
  waybar_mapped || pkill -USR1 -x waybar 2>/dev/null || true
fi
