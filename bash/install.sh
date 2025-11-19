#!/bin/bash

if [ -z "$DOTFILES_LOCATION" ]
then
        DOTFILES_LOCATION="\${HOME}/dotfiles"
fi

ln -sf "${DOTFILES_LOCATION}/bash/bash_aliases" "${HOME}/.bash_aliases"
ln -sf "${DOTFILES_LOCATION}/bash/bashrc" "${HOME}/.bashrc"
ln -sf "${DOTFILES_LOCATION}/bash/bash_profile" "${HOME}/.bash_profile"

# convert to zsh
GENERATED_ZSH="${DOTFILES_LOCATION}/bash/generatedzsh"
cat "${DOTFILES_LOCATION}/bash/zshrc" > "$GENERATED_ZSH"
cat "${DOTFILES_LOCATION}/bash/bash_aliases" >> "$GENERATED_ZSH"
ln -sf "$GENERATED_ZSH" "${HOME}/.zshrc"


PATH="${DOTFILES_LOCATION}/bash:${PATH}"
[ -f "${HOME}/.bash_profile" ] && source "${HOME}/.bash_profile"
[ -f "${HOME}/.bashrc" ] && source "${HOME}/.bashrc"
[ -f "${HOME}/.bash_aliases" ] && source "${HOME}/.bash_aliases"

if command -v zsh >/dev/null 2>&1 && [ -f "${HOME}/.zshrc" ]; then
    zsh -c "source ${HOME}/.zshrc"
fi
