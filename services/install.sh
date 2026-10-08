#!/bin/bash

# Background services that should be running whenever this machine is on.

source "$(dirname "${BASH_SOURCE[0]}")/../lib.sh"

# Let user services start at boot, before anyone logs in
if [ "$(loginctl show-user "$USER" -p Linger --value 2> /dev/null)" != "yes" ]
then
	loginctl enable-linger "$USER"
fi

# Caddy web server (system service)
if command -v pacman > /dev/null && ! pacman -Q caddy > /dev/null 2>&1
then
	sudo pacman -S --needed --noconfirm caddy
fi
if command -v caddy > /dev/null && ! systemctl is-enabled --quiet caddy
then
	sudo systemctl enable --now caddy
fi

# Combo dev stack, when the checkout exists
if [ -x "${HOME}/combo/bin/dev" ]
then
	link "${DOTFILES_LOCATION}/services/systemd/combo-dev.service" "${HOME}/.config/systemd/user/combo-dev.service"

	# Let Combo's containers reach the app's dev ports through ufw
	if command -v ufw > /dev/null && ! grep -q "46200:46399" /etc/ufw/user.rules 2> /dev/null
	then
		sudo ufw allow proto tcp from 172.16.0.0/12 to any port 46200:46399 comment 'combo dev: containers to app'
	fi
fi

systemctl --user daemon-reload

# Enable whichever of these user services are installed (their own tools create the units)
for unit in combo-dev paperclipai hermes-gateway
do
	if systemctl --user cat "${unit}.service" > /dev/null 2>&1 && ! systemctl --user is-enabled --quiet "${unit}.service"
	then
		systemctl --user enable "${unit}.service"
	fi
done
