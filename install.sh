#!/bin/bash

set -e

###
# Installation of packages, configurations, and dotfiles.
###
DOTFILES_LOCATION=$(pwd)
export DOTFILES_LOCATION;

###
# Install dependencies
###
for i in $DOTFILES_LOCATION/*/install.sh
do
	bash $i
done
