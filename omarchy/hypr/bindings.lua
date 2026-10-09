-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Vim-style window movement: SUPER + H/J/K/L moves the active window.
-- The defaults these keys replaced move to their SHIFT variants.
hl.unbind("SUPER + J") -- was: Toggle window split
hl.unbind("SUPER + K") -- was: Keybindings
hl.unbind("SUPER + L") -- was: Toggle workspace layout
o.bind("SUPER + H", "Move window left", hl.dsp.window.move({ direction = "l" }))
o.bind("SUPER + J", "Move window down", hl.dsp.window.move({ direction = "d" }))
o.bind("SUPER + K", "Move window up", hl.dsp.window.move({ direction = "u" }))
o.bind("SUPER + L", "Move window right", hl.dsp.window.move({ direction = "r" }))

o.bind("SUPER + SHIFT + J", "Toggle window split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + SHIFT + K", "Keybindings", "omarchy-menu-keybindings")
o.bind("SUPER + SHIFT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")

-- macOS-style screenshot shortcut, same as PRINT. code:14 is the 5 key.
o.bind("ALT + SHIFT + code:14", "Screenshot", "omarchy-capture-screenshot")
