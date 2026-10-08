#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

if [ "$(uname)" = "Darwin" ]
then
	settings_dir="${HOME}/Library/Application Support/Code/User"
else
	settings_dir="${HOME}/.config/Code/User"
fi

link "${DOTFILES_LOCATION}/vscode/settings.json" "${settings_dir}/settings.json"

if ! command -v code > /dev/null
then
	exit 0
fi

installed="$(code --list-extensions 2> /dev/null)"
while read -r extension
do
	[ -n "$extension" ] || continue
	if ! grep -Fxqi "$extension" <<< "$installed"
	then
		code --install-extension "$extension" > /dev/null
		echo "    installed $extension"
	fi
done < "${DOTFILES_LOCATION}/vscode/extensions.txt"
