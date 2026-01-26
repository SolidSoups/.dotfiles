#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Install packages
echo "Installing packages"
	sudo dnf install -y \
		neovim \
		tmux \
		git \
		ripgrep \
		fd-find \
		fzf \
		stow \
		zoxide

# Stow all packages
echo "Stowing all directories"
cd "$DOTFILES_DIR"
stow -v */

# Append to bash
echo "Appending to .bashrc"
cat >> "$HOME/.bashrc" << 'EOF'

# Custom additions
export EDITOR=nvim
export VISUAL=nvim
alias vim=nvim
alias ll='ls -alh'
alias grep='grep --color=auto'

# Zoxide config
eval "$(zoxide init --cmd cd bash)"

EOF

# Source new bashrc
if [[ -f "$HOME/.bashrc" ]]; then
    set +u
	source "$HOME/.bashrc"
    set -u
fi

echo "Installation finished."
