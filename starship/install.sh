#!/bin/bash

if [ -z "$DOTFILES_LOCATION" ]
then
        DOTFILES_LOCATION="${HOME}/dotfiles"
fi

mkdir -p $HOME/.config && touch $HOME/.config/starship.toml
ln -sf "${DOTFILES_LOCATION}/starship/starship.toml" "${HOME}/.config/starship.toml"
