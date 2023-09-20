# My Termux Dotfiles

prerequisites: Unexpected Keyboard, Termux:styles

## Update and Upgrade Packages, Install Git

    apt update && apt upgrade -y && apt update && apt install git

## Clone Dotfiles

### Fork Repo and replace git clone url with your own

    rm -rf .termux/termux.properties
    git clone --bare https://github.com/GR3YH4TT3R93/dotfiles.git ~/GitHub/dotfiles
    git --git-dir=$HOME/GitHub/dotfiles --work-tree=$HOME checkout
    git --git-dir=$HOME/GitHub/dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no

## Run Install Script

    bash install.sh

## Press Ctrl+d to exit zsh and continue script after oh-my-zsh script completes

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
