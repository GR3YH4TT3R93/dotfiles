# Update and Upgrade Packages

    apt update && apt upgrade -y

# Install Nala Package Manager, Z Shell, Termux Clipboard, Git, GitHub CLI, Neovim, NodeJS, Python-pip, Ruby, wget, logo-ls

    apt update && apt install nala zsh termux-api git gh neovim nodejs python-pip ruby wget logo-ls -y

## Install pynvim

    /data/data/com.termux/usr/bin/python3 -m pip install pynvim

## Install neovim npm package

    npm install -g neovim

## Install neovim gem package

    gem install neovim

# Set up GitHub auth

    gh auth login

# Install MOTD

    rm /data/data/com.termux/files/usr/etc/motd
    git clone https://github.com/GR3YH4TT3R93/termux-motd.git /data/data/com.termux/files/usr/etc/motd
    echo "/data/data/com.termux/files/usr/etc/motd/init.sh" >> /data/data/com.termux/files/usr/etc/profile # or .zprofile if using zsh

# Install Oh My Zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# Install Oh My Zsh plugins

## Auto-Suggestions

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

## Completions

    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

## History Substring Search

    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

## Syntax Highlighting

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

## Git Flow Completions

    git clone https://github.com/bobthecow/git-flow-completion ~/.oh-my-zsh/custom/plugins/git-flow-completion

# Clone Dotfiles

    rm .termux/termux.properties .zshrc
    git clone --bare https://github.com/GR3YH4TT3R93/dotfiles.git ~/GitHub/dotfiles
    git --git-dir=$HOME/GitHub/dotfiles --work-tree=$HOME checkout

# Install Nvim Plugins

    :PlugInstall
