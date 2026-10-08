#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

link "${DOTFILES_LOCATION}/bash/bash_aliases" "${HOME}/.bash_aliases"
link "${DOTFILES_LOCATION}/bash/bashrc" "${HOME}/.bashrc"
link "${DOTFILES_LOCATION}/bash/bash_profile" "${HOME}/.bash_profile"

# Generate a zshrc from the shared aliases, only if zsh is installed
if command -v zsh > /dev/null 2>&1; then
	GENERATED_ZSH="${DOTFILES_LOCATION}/bash/generatedzsh"
	cat "${DOTFILES_LOCATION}/bash/zshrc" "${DOTFILES_LOCATION}/bash/bash_aliases" > "$GENERATED_ZSH"
	link "$GENERATED_ZSH" "${HOME}/.zshrc"
fi
