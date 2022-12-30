#!/bin/bash

ln -sf "${DOTFILES_LOCATION}/bash/bash_aliases" "${HOME}/.bash_aliases"
ln -sf "${DOTFILES_LOCATION}/bash/bashrc" "${HOME}/.bashrc"
ln -sf "${DOTFILES_LOCATION}/bash/bash_profile" "${HOME}/.bash_profile"

source "${HOME}/.bashrc"
