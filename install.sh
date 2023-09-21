#!/data/data/com.termux/files/usr/bin/bash
# Install script for My Termux Dotfiles

# Install Nala Package Manager, Z Shell, Termux Clipboard, Git, GitHub CLI, Neovim, NodeJS, Python-pip, Ruby, wget, logo-ls, Timewarrior, Taskwarrior, htop

    apt update && apt install nala -y && nala install zsh termux-api gh neovim nodejs python-pip ruby wget logo-ls timewarrior taskwarrior htop -y

# Install pynvim

    python -m pip install pynvim

# Install neovim npm package

    npm install -g neovim

# Install neovim gem package

    gem install neovim

# Update Gem
    gem update --system

# Set up GitHub auth

    gh auth login

# Install MOTD

    rm /data/data/com.termux/files/usr/etc/motd
    git clone https://github.com/GR3YH4TT3R93/termux-motd.git /data/data/com.termux/files/usr/etc/motd
    echo "/data/data/com.termux/files/usr/etc/motd/init.sh" >> /data/data/com.termux/files/usr/etc/zprofile

# Install Oh My Zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/GR3YH4TT3R93/ohmyzsh/master/tools/install.sh)"

# Set the ZSH_CUSTOM variable
    ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
# Install Powerlevel10k

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"

# Install Oh My Zsh plugins
# Auto-Suggestions

    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

# Completions

    git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"

# History Substring Search

    git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# Syntax Highlighting

    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# Git Flow Completions

    git clone https://github.com/bobthecow/git-flow-completion "$ZSH_CUSTOM/plugins/git-flow-completion"

# Zsh Vi Mode

    git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode"
# Magic Enter

    git clone https://github.com/GR3YH4TT3R93/magic-enter "$ZSH_CUSTOM/plugins/magic-enter"

# Hide README.md install.sh

    git --git-dir="$HOME/GitHub/dotfiles" --work-tree="$HOME" mv install.sh ~/.termux/install.sh
    git --git-dir="$HOME/GitHub/dotfiles" --work-tree="$HOME" mv README.md ~/.termux/README.md

# Enable Storage

    termux-setup-storage

# Set Up Git Credentials
echo "Time to set up your Git credentials!"

# Prompt the user for their Git username
read -p "Enter your Git username: " username

# Prompt the user for their Git email
read -p "Enter your Git email: " email

# Prompt the user to choose between global and system-wide configuration
read -p "Would you like to set your Git configuration system-wide? (Yes/No): " choice

if [ "$choice" = "no" ] || [ "$choice" = "N" ] || [ "$choice" = "n" ]; then
    # Set the Git username and email globally
    git config --global user.name "$username"
    git config --global user.email "$email"
    echo "Git credentials configured globally!"
elif [ "$choice" = "yes" ] || [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
    # Set the Git username and email system-wide
    git config --system user.name "$username"
    git config --system user.email "$email"
    echo "Git credentials configured system-wide!"
else
    echo "Invalid choice. Git credentials not configured."
fi


# Finish Setup

echo Setup Complete! Press Ctrl+D for changes to take effect.
