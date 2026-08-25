# Post-rebase setup recipes (run with: ujust <recipe>)

# Set the current user's login shell to fish.
# Needed because Anaconda creates the account during the original spin
# install (bash); /etc/default/useradd only covers users created later.
# chsh needs no root when the target shell is listed in /etc/shells.
fish-shell:
    #!/usr/bin/env bash
    set -euo pipefail
    current="$(getent passwd "$USER" | cut -d: -f7)"
    if [[ "$current" == "/usr/bin/fish" ]]; then
        echo "login shell already fish"
        exit 0
    fi
    grep -qx "/usr/bin/fish" /etc/shells || \
        echo "/usr/bin/fish" | sudo tee -a /etc/shells >/dev/null
    chsh -s /usr/bin/fish "$USER"
    echo "login shell set to fish (takes effect on next login)"

# Clone a dotfiles repo and stow every top-level package into $HOME.
# The repo can live anywhere; --target pins the link destination, so
# ~/.dotfiles and ~/.config/dotfiles both work.
# Usage: ujust dotfiles git@github.com:<user>/<repo>.git [dest]
dotfiles url dest="$HOME/.config/dotfiles":
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ -d "{{dest}}/.git" ]]; then
        git -C "{{dest}}" pull --ff-only
    else
        git clone "{{url}}" "{{dest}}"
    fi
    cd "{{dest}}"
    stow --target="$HOME" -S */
