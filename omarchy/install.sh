#!/bin/bash

# Only relevant on Omarchy machines
if [ ! -d /usr/share/omarchy ]
then
	exit 0
fi

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

link "${DOTFILES_LOCATION}/omarchy/hypr/input.lua" "${HOME}/.config/hypr/input.lua"
link "${DOTFILES_LOCATION}/omarchy/omarchy/shell.json" "${HOME}/.config/omarchy/shell.json"

# Material Monokai High Contrast, to match VS Code. Re-applying the theme
# regenerates every themed config, so only do it when it isn't already set.
theme="material-monokai-hc"
link "${DOTFILES_LOCATION}/omarchy/themes/${theme}" "${HOME}/.config/omarchy/themes/${theme}"
if [ "$(cat "${HOME}/.local/state/omarchy/current/theme.name" 2> /dev/null)" != "$theme" ]
then
	omarchy theme set "$theme"
fi

# Never idle-lock or start the screensaver
omarchy toggle idle stay-awake > /dev/null

hyprctl reload > /dev/null 2>&1 || true
