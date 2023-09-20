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

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k"

# Install Oh My Zsh plugins

# Auto-Suggestions

    git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"

# Completions

    git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions"

# History Substring Search

    git clone https://github.com/zsh-users/zsh-history-substring-search "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search"

# Syntax Highlighting

    git clone https://github.com/zsh-users/zsh-syntax-highlighting "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"

# Git Flow Completions

    git clone https://github.com/bobthecow/git-flow-completion "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-flow-completion"

# Zsh Vi Mode

    git clone https://github.com/jeffreytse/zsh-vi-mode "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode"

# reset .zshrc
    mv .zshrc.pre-oh-my-zsh .zshrc

# Clean Install files

    rm -rf .shell.pre-oh-my-zsh

# Stop Tracking install.sh

    git --git-dir="$HOME/GitHub/dotfiles" --work-tree="$HOME" rm install.sh
