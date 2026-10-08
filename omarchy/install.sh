#!/bin/bash

# Only relevant on Omarchy machines
if [ ! -d /usr/share/omarchy ]
then
	exit 0
fi

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

link "${DOTFILES_LOCATION}/omarchy/hypr/input.lua" "${HOME}/.config/hypr/input.lua"
link "${DOTFILES_LOCATION}/omarchy/omarchy/shell.json" "${HOME}/.config/omarchy/shell.json"

# Never idle-lock or start the screensaver
omarchy toggle idle stay-awake > /dev/null

hyprctl reload > /dev/null 2>&1 || true
