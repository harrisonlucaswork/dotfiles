#!/usr/bin/bash

ln -sf "${DOTFILES_LOCATION}/bash/bashrc" "${HOME}/.bashrc"
ln -sf "${DOTFILES_LOCATION}/bash/bash_profile" "${HOME}/.bash_profile"
ln -sf "${DOTFILES_LOCATION}/bash/bash_aliases" "${HOME}/.bash_aliases"
source $HOME/.bash_profile
