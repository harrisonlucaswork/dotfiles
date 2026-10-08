#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

link "${DOTFILES_LOCATION}/claude/CLAUDE.md" "${HOME}/.claude/CLAUDE.md"

for skill in "${DOTFILES_LOCATION}"/claude/skills/*/
do
	skill="${skill%/}"
	link "$skill" "${HOME}/.claude/skills/$(basename "$skill")"
done
