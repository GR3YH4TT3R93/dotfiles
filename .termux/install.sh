#!/data/data/com.termux/files/usr/bin/bash
# Install script for My Termux Dotfiles
# Set custom variables
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
RED="\e[31m"
GREEN="\e[32m"
ENDCOLOR="\e[0m"

function error_exit {
  echo -e "${RED}Error: $1${ENDCOLOR}" >&2
  exit 1
}

# Set Up Storage
termux-setup-storage

# Install Nala Package Manager, Z Shell, Termux Clipboard, Git, GitHub CLI, Neovim, NodeJS, Python-pip, Ruby, wget, logo-ls, Timewarrior, Taskwarrior, htop
apt update && apt upgrade -y || error_exit "${RED}Failed to update packages.${ENDCOLOR}"
apt update && apt install nala -y
nala install zsh termux-api gh neovim nodejs python-pip ruby wget logo-ls timewarrior taskwarrior htop -y || error_exit "${RED}Failed to install packages.${ENDCOLOR}"

# Install pynvim, pnpm and neovim npm package, and neovim gem package
python -m pip install pynvim || error_exit "${RED}Failed to install pynvim.${ENDCOLOR}"
npm install -g pnpm neovim || error_exit "${RED}Failed to install neovim npm package.${ENDCOLOR}"
gem install neovim || error_exit "${RED}Failed to install neovim gem package.${ENDCOLOR}"
gem update --system || error_exit "${RED}Failed to update gem.${ENDCOLOR}"

# Set up GitHub auth
gh auth login || error_exit "${RED}Failed to set up GitHub auth.${ENDCOLOR}"

# Install MOTD
rm /data/data/com.termux/files/usr/etc/motd
git clone https://github.com/GR3YH4TT3R93/termux-motd.git /data/data/com.termux/files/usr/etc/motd
echo "/data/data/com.termux/files/usr/etc/motd/init.sh" >> /data/data/com.termux/files/usr/etc/zprofile

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/GR3YH4TT3R93/ohmyzsh/master/tools/install.sh)"

# Clean up excess files
rm ".shell.pre-oh-my-zsh"

# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" || error_exit "${RED}Failed to install Powerlevel10k.${ENDCOLOR}"

# Install Oh My Zsh plugins
# Auto-Suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || error_exit "${RED}Failed to install zsh-autosuggestions.${ENDCOLOR}"

# Completions
git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions" || error_exit "${RED}Failed to install zsh-completions.${ENDCOLOR}"

# History Substring Search
git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search" || error_exit "${RED}Failed to install zsh-history-substring-search.${ENDCOLOR}"

# Syntax Highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || error_exit "${RED}Failed to install zsh-syntax-highlighting.${ENDCOLOR}"

# Git Flow Completions
git clone https://github.com/bobthecow/git-flow-completion "$ZSH_CUSTOM/plugins/git-flow-completion" || error_exit "${RED}Failed to install git-flow-completion.${ENDCOLOR}"

# Zsh Vi Mode
git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode" || error_exit "${RED}Failed to install zsh-vi-mode.${ENDCOLOR}"

# Magic Enter
git clone https://github.com/GR3YH4TT3R93/magic-enter "$ZSH_CUSTOM/plugins/magic-enter" || error_exit "${RED}Failed to install magic-enter.${ENDCOLOR}"

# Hide README.md
git --git-dir="$HOME/GitHub/dotfiles" --work-tree="$HOME" mv README.md ~/.termux/README.md || error_exit "${RED}Failed to hide README.md.${ENDCOLOR}"

# Set Up Git Credentials
echo -e "${GREEN}Time to set up your Git credentials!${ENDCOLOR}"

# Prompt the user for their Git username
read -p "Enter your Git username: " username

# Prompt the user for their Git email
read -p "Enter your Git email: " email

# Prompt the user to choose between global and system-wide configuration
read -p "Would you like to set your Git configuration system-wide? (Yes/No): " choice

if [[ "$choice" == [Yy]* ]]; then
  # Set the Git username and email system-wide
  git config --system user.name "$username"
  git config --system user.email "$email"
  git config --system push.autoSetupRemote true
  git config --system fetch.prune true
  git config --system core.editor nvim
  git config --system init.defaultBranch main
  git config --system color.status auto
  git config --system color.branch auto
  git config --system color.interactive auto
  git config --system color.diff auto
  git config --system status.short true
  # Transfer gh helper config to system config
  cat "$HOME/.gitconfig" >> "/data/data/com.termux/files/usr/etc/gitconfig"
  # Clean up unnecessary file
  rm "$HOME/.gitconfig"
  echo -e "${GREEN}Git credentials configured system-wide.${ENDCOLOR}"
else
  # Set the Git username and email globally
  git config --global user.name "$username"
  git config --global user.email "$email"
  git config --global push.autoSetupRerun true
  git config --system fetch.prune true
  git config --global core.editor nvim
  git config --global init.defaultBranch main
  git config --global color.status auto
  git config --global color.branch auto
  git config --global color.interactive auto
  git config --global color.diff auto
  git config --global status.short true
  echo -e "${GREEN}Git credentials configured globally.${ENDCOLOR}"
fi

# Finish Setup
echo -e "${GREEN}Setup Complete! Press Ctrl+D for changes to take effect.${ENDCOLOR}"
