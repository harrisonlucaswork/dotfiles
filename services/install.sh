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

# ngrok tunnel to Combo instance 01 (the night shift borrows it during runs; authtoken lives in ngrok's own config)
if command -v ngrok > /dev/null
then
	link "${DOTFILES_LOCATION}/services/systemd/ngrok.service" "${HOME}/.config/systemd/user/ngrok.service"
fi

systemctl --user daemon-reload

# Enable whichever of these user services are installed (their own tools create the units)
for unit in combo-dev ngrok hermes-gateway
do
	if systemctl --user cat "${unit}.service" > /dev/null 2>&1 && ! systemctl --user is-enabled --quiet "${unit}.service"
	then
		systemctl --user enable "${unit}.service"
	fi
done

# Tailnet: Combo day instance on :443, night shift dashboard on :8443
if command -v tailscale > /dev/null && tailscale status > /dev/null 2>&1
then
	tailscale serve --bg --https=443 http://127.0.0.1:46201 > /dev/null
	tailscale serve --bg --https=8443 http://127.0.0.1:3200 > /dev/null
fi
