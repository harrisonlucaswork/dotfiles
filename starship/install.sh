#!/bin/bash

if [ -z "$DOTFILES_LOCATION" ]
then
        DOTFILES_LOCATION="${HOME}/dotfiles"
fi

ln -sf "${DOTFILES_LOCATION}/starship/starship.toml" "${HOME}/.config/starship.toml"
