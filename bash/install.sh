#!/bin/bash

if [ -z "$DOTFILES_LOCATION" ]
then
	DOTFILES_LOCATION="${HOME}/dotfiles"
fi

ln -sf "${DOTFILES_LOCATION}/bash/bash_aliases" "${HOME}/.bash_aliases"
ln -sf "${DOTFILES_LOCATION}/bash/bashrc" "${HOME}/.bashrc"
ln -sf "${DOTFILES_LOCATION}/bash/bash_profile" "${HOME}/.bash_profile"

PATH=${DOTFILES_LOCATION}/bash:${PATH}
source "${HOME}/.bash_profile"
source "${HOME}/.bashrc"
source "${HOME}/.bash_aliases"
