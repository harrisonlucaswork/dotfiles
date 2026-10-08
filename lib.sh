#!/bin/bash
# Shared helpers for component installers.

: "${DOTFILES_LOCATION:=${HOME}/dotfiles}"

# link <source> <target>: symlink target -> source, backing up any existing real file
link() {
	local src="$1" dest="$2"
	mkdir -p "$(dirname "$dest")"
	if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
		return
	fi
	if [ -e "$dest" ] && [ ! -L "$dest" ]; then
		local backup="${dest}.bak.$(date +%s)"
		mv "$dest" "$backup"
		echo "    backed up $dest -> $backup"
	fi
	ln -sfn "$src" "$dest"
	echo "    linked $dest"
}
