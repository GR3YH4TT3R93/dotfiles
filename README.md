# My Termux Dotfiles

prerequisites: Unexpected Keyboard, Termux:styles

## Update and Upgrade Packages

    apt update && apt upgrade -y

## Install Nala Package Manager, Z Shell, Termux Clipboard, Git, GitHub CLI, Neovim, NodeJS, Python-pip, Ruby, wget, logo-ls, Timewarrior, Taskwarrior

    apt update && apt install nala -y && nala install zsh termux-api git gh neovim nodejs python-pip ruby wget logo-ls timewarrior taskwarrior -y

### Install pynvim

    python -m pip install pynvim

### Install neovim npm package

    npm install -g neovim

### Install neovim gem package

    gem install neovim

## Set up GitHub auth

    gh auth login

## Install MOTD

    rm /data/data/com.termux/files/usr/etc/motd
    git clone https://github.com/GR3YH4TT3R93/termux-motd.git /data/data/com.termux/files/usr/etc/motd
    echo "/data/data/com.termux/files/usr/etc/motd/init.sh" >> /data/data/com.termux/files/usr/etc/zprofile

## Install Oh My Zsh

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install Powerlevel10k

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

## Install Oh My Zsh plugins

### Auto-Suggestions

    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

### Completions

    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

### History Substring Search

    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search

### Syntax Highlighting

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

### Git Flow Completions

    git clone https://github.com/bobthecow/git-flow-completion ~/.oh-my-zsh/custom/plugins/git-flow-completion

### Zsh Vi Mode

    git clone https://github.com/jeffreytse/zsh-vi-mode \
    $ZSH_CUSTOM/plugins/zsh-vi-mode

## Clone Dotfiles

### Fork Repo and replace git clone url with your own

    rm .termux/termux.properties .zshrc
    git clone --bare https://github.com/GR3YH4TT3R93/dotfiles.git ~/GitHub/dotfiles
    git --git-dir=$HOME/GitHub/dotfiles --work-tree=$HOME checkout
    git --git-dir=$HOME/GitHub/dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no

## Restart Termux

## Install Nvim Plugins

    e # open editor

## Custom Unexpected Keyboard Config

    <?xml version="1.0" encoding="UTF-8" standalone="yes"?>
    <keyboard>
      <row>
        <key key0="q" key2="superscript" key4="esc"/>
        <key key0="w" key2="2" key3="\@" key4="~"/>
        <key key0="e" key2="3" key4="\#"/>
        <key key0="r" key2="4" key4="$"/>
        <key key0="t" key2="5" key4="%"/>
        <key key0="y" key2="6" key3="^"/>
        <key key0="u" key2="7" key3="&amp;"/>
        <key key0="i" key2="8" key3="*"/>
        <key key0="o" key2="9" key3="\?"/>
        <key key0="p" key1="subscript" key2="0" key3="!"/>
      </row>
      <row>
        <key shift="0.5" key0="a" key2="tab" />
        <key key0="s" key3="{" key4="}"/>
        <key key0="d" key3="[" key4="]"/>
        <key key0="f" key3="(" key4=")"/>
        <key key0="g" key3="/" key4="\\"/>
        <key key0="h" key3="&lt;" key4=">"/>
        <key key0="j" key3="+" key4="="/>
        <key key0="k" key3="_" key4="-"/>
        <key key0="l" key1="`" key3=":" key4=";"/>
      </row>
      <row>
        <key width="1.5" key0="shift" key2="loc capslock"/>
        <key key0="z" key3="paste" key4="copy"/>
        <key key0="x" key3="selectAll" key4="cut"/>
        <key key0="c" key3="undo" key4="redo"/>
        <key key0="v" key3="." key4=","/>
        <key key0="b" key3="&quot;" key4="'"/>
        <key key0="n" key3="home" key4="end"/>
        <key key0="m" key3="page_up" key4="page_down"/>
        <key width="1.5" key0="backspace" key2="delete"/>
      </row>
    </keyboard>
