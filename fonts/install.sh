#!/bin/bash

# The font files are paid fonts, so they live untracked in fonts/files/
# (gitignored) and have to be copied onto each machine by hand.

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

shopt -s nullglob
fonts=("${DOTFILES_LOCATION}"/fonts/files/*.{ttf,otf})

if [ ${#fonts[@]} -eq 0 ]
then
	echo "    no fonts in fonts/files, skipping"
	exit 0
fi

if [ "$(uname)" = "Darwin" ]
then
	font_dir="${HOME}/Library/Fonts"
else
	font_dir="${HOME}/.local/share/fonts"
fi

mkdir -p "$font_dir"
changed=0
for font in "${fonts[@]}"
do
	if ! cmp -s "$font" "${font_dir}/$(basename "$font")"
	then
		cp "$font" "$font_dir/"
		echo "    installed $(basename "$font")"
		changed=1
	fi
done

if [ $changed -eq 1 ] && command -v fc-cache > /dev/null
then
	fc-cache -f "$font_dir" > /dev/null
fi
