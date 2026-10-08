#!/bin/bash

# Only relevant on machines with the MLP platform checkout
if [ ! -d "/mnt/mlp/platform/.git" ]
then
	exit 0
fi

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

cp -p "$DOTFILES_LOCATION/platformhooks/pre-commit" /mnt/mlp/platform/.git/hooks/pre-commit
