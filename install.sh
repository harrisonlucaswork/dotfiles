#!/bin/bash

set -e

###
# Installation of packages, configurations, and dotfiles.
###
DOTFILES_LOCATION="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_LOCATION

###
# Run each component's installer
###
for i in "$DOTFILES_LOCATION"/*/install.sh
do
	echo "==> $(basename "$(dirname "$i")")"
	bash "$i"
done
