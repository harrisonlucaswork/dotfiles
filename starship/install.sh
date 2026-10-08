#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

link "${DOTFILES_LOCATION}/starship/starship.toml" "${HOME}/.config/starship.toml"
