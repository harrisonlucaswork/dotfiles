#!/bin/bash

if [ ! -d "/mnt/mlp/platform/.git" ]
then
	exit 0
fi

if [ -z "$DOTFILES_LOCATION" ]
then
	DOTFILES_LOCATION="${HOME}/dotfiles"
fi

cp -p $DOTFILES_LOCATION/platformhooks/pre-commit /mnt/mlp/platform/.git/hooks/pre-commit
