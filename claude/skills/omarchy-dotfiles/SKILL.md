---
name: omarchy-dotfiles
description: REQUIRED alongside the omarchy skill whenever Omarchy, Hyprland, the Omarchy shell/bar, terminals, themes, fonts or any other desktop config on this machine is customized. Every such change must also be captured in ~/dotfiles/omarchy (linked from its install.sh), committed, and pushed to GitHub.
---

# Omarchy changes live in ~/dotfiles

Lucas manages this machine's Omarchy setup from `~/dotfiles` (public GitHub
repo). The packaged `omarchy` skill covers *how* to customize; this skill adds
where the result must end up. A change made only under `~/.config` is not done.

## After every Omarchy customization

1. **Move the change into the repo.** Put the file under `~/dotfiles/omarchy/`,
   mirroring its path under `~/.config/` (e.g. `~/.config/hypr/bindings.lua` ->
   `~/dotfiles/omarchy/hypr/bindings.lua`, custom themes in
   `~/dotfiles/omarchy/themes/<slug>/`). If the live file is a symlink into
   dotfiles already, edit the dotfiles copy and you are done with this step.
2. **Wire it up in `~/dotfiles/omarchy/install.sh`.** Use `link <src> <dest>`
   from `../lib.sh` (it backs up a real file before symlinking). For changes
   made by a command rather than a file (e.g. `omarchy toggle ...`,
   `omarchy theme set ...`), add the command there, guarded so it only acts
   when needed. The installer must stay safe to run repeatedly and keep its
   early exit when `/usr/share/omarchy` is missing.
3. **Apply and verify** by running `bash ~/dotfiles/omarchy/install.sh` (with
   `DOTFILES_LOCATION=~/dotfiles`); run it a second time to confirm it is
   idempotent. Then check the change took effect (`hyprctl configerrors`, a
   screenshot, etc.).
4. **Commit** only the files for this change, with a clear message. Leave
   unrelated uncommitted work in the repo alone.
5. **Push** to GitHub (`git -C ~/dotfiles push`). Lucas has authorized pushing
   for these changes. The SSH key (`~/.ssh/id_rsa_vm`) has a passphrase, so if
   the push fails for lack of a terminal or agent, ask Lucas to run
   `! git -C ~/dotfiles push`.

## Never commit secrets or paid assets

The repo is public. `fonts/files/` holds paid fonts and is gitignored; keep it
that way and check `git diff --cached --name-only` before every commit.

## Other dotfiles components

Changes that belong to another component (VS Code in `vscode/`, fonts in
`fonts/`, bash in `bash/`, starship in `starship/`) go in that component's
folder and `install.sh` instead, following the same steps.
