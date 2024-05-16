# My Termux Dotfiles

### Requirements

- figlet (termux-banner only)
- [FiraCode NerdFont](https://github.com/tonsky/FiraCode) (disk-space progress bar ligatures)
- [Unexpected Keyboard](https://f-droid.org/packages/juloo.keyboard2/)

## Update and Upgrade Packages, Install Git and gh

    apt update && apt install git

## Clone Dotfiles As Bare Repo

### ⚠️ Fork Repo and replace git clone url with your own! ⚠️

    rm -rf .termux/termux.properties
    ## REPLACE THIS URL ⬇️
    git clone --bare --recurse-submodules https://github.com/GR3YH4TT3R93/dotfiles.git ~/GitHub/dotfiles
    ## REPLACE THIS URL ⬆️
    git --git-dir=$HOME/GitHub/dotfiles --work-tree=$HOME checkout
    git --git-dir=$HOME/GitHub/dotfiles --work-tree=$HOME config --local status.showUntrackedFiles no
    ## THE NEXT LINE AUTOMATICALLY RUNS THE AUTO-INSTALLER REMOVE IF YOU WANT TO RUN IT MANUALLY
    ~/.termux/autoinstall.sh

## Clone Dotfiles as Normal Repo

    rm -rf .termux
    git clone --recurse-submodules https://github.com/GR3YH4TT3R93/dotfiles.git ~/

## Run Install Script

    # Manual, you choose!
    ~/.termux/install.sh

    # Auto, installs everything with minimal interaction
    ~/.termux/autoinstall.sh

## For both methods set new remote!

    bare:
    b remote set-url https://your.git.fork/repo

    regular:
    git init
    git config --local status.showUntrackedFiles no
    git remote add origin https://your.git.fork/repo

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
        <key key0="g" key3="/" key4="\" key7="|"/>
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

# Building Neovim from source

- Install Deps

      apt install luarocks cmake
      luarocks install mpack
      luarocks install lpeg

- Clone repo

      git clone https://github.com/neovim/neovim --depth 1 -b v0.10.0

- CD into Repo

        neovim/ # or cd neovim

  <!-- - Apply patches [funcs.c](https://github.com/termux/termux-packages/blob/07659c278ea102b65b5ea58dc0b2c3e6ec15e5f1/packages/neovim/src-nvim-eval-funcs.c.patch#L4) and [stdpaths.c](https://github.com/termux/termux-packages/blob/1a939447bf9ab7504cab423ebaad39595827171d/packages/neovim/src-nvim-os-stdpaths.c.patch#L4) -->

<!--       e ./src/nvim/eval/funcs.c # line 3118 -->

<!--       e ./src/nvim/os/stdpaths.c # Line 55 & 56 -->

- Build and Install

      cmake -S . -B build_dir -D CMAKE_INSTALL_PREFIX=$PREFIX
      cmake --build build_dir -j8
      cmake --install build_dir

- Clean up Install files

      cd
      rm -rf neovim

# 📚 Usage

Use `ESC` or `CTRL-[` to enter `Normal mode`.

But some people may like the custom escape key such as `jj`, `jk` and so on,
if you want to custom the escape key, you can learn more from [here](#custom-escape-key).

## History

- `ctrl-p` : Previous command in history
- `ctrl-n` : Next command in history
- `/` : Search backward in history
- `n` : Repeat the last `/`

## Mode indicators

`Normal mode` is indicated with block style cursor, and `Insert mode` with
beam style cursor by default.

## Vim edition

In `Normal mode` you can use `vv` to edit current command line in an editor
(e.g. `vi`/`vim`/`nvim`...), because it is bound to the `Visual mode`.

You can change the editor by `ZVM_VI_EDITOR` option, by default it is
`$EDITOR`.

## Movement

- `$` : To the end of the line
- `^` : To the first non-blank character of the line
- `0` : To the first character of the line
- `w` : [count] words forward
- `W` : [count] WORDS forward
- `e` : Forward to the end of word [count] inclusive
- `E` : Forward to the end of WORD [count] inclusive
- `b` : [count] words backward
- `B` : [count] WORDS backward
- `t{char}` : Till before [count]'th occurrence of {char} to the right
- `T{char}` : Till before [count]'th occurrence of {char} to the left
- `f{char}` : To [count]'th occurrence of {char} to the right
- `F{char}` : To [count]'th occurrence of {char} to the left
- `;` : Repeat latest f, t, F or T [count] times
- `,` : Repeat latest f, t, F or T in opposite direction

## Insertion

- `i` : Insert text before the cursor
- `I` : Insert text before the first character in the line
- `a` : Append text after the cursor
- `A` : Append text at the end of the line
- `o` : Insert new command line below the current one
- `O` : Insert new command line above the current one

## Surround

There are 2 kinds of keybinding mode for surround operating, default is
`classic` mode, you can choose the mode by setting `ZVM_VI_SURROUND_BINDKEY`
option.

1. `classic` mode (verb->s->surround)

- `S"` : Add `"` for visual selection
- `ys"` : Add `"` for visual selection
- `cs"'` : Change `"` to `'`
- `ds"` : Delete `"`

2.  `s-prefix` mode (s->verb->surround)

- `sa"` : Add `"` for visual selection
- `sd"` : Delete `"`
- `sr"'` : Change `"` to `'`

Note that key sequences must be pressed in fairly quick succession to avoid a timeout. You may extend this timeout with the [`ZVM_KEYTIMEOUT` option](#readkey-engine).

#### How to select surround text object?

- `vi"` : Select the text object inside the quotes
- `va(` : Select the text object including the brackets

Then you can do any operation for the selection:

1. Add surrounds for text object

- `vi"` -> `S[` or `sa[` => `"object"` -> `"[object]"`
- `va"` -> `S[` or `sa[` => `"object"` -> `["object"]`

2. Delete/Yank/Change text object

- `di(` or `vi(` -> `d`
- `ca(` or `va(` -> `c`
- `yi(` or `vi(` -> `y`

## Increment and Decrement

In normal mode, typing `ctrl-a` will increase to the next keyword, and typing
`ctrl-x` will decrease to the next keyword. The keyword can be at the cursor,
or to the right of the cursor (on the same line). The keyword could be as
below:

- Number (Decimal, Hexadecimal, Binary...)
- Boolean (True or False, Yes or No, On or Off...)
- Weekday (Sunday, Monday, Tuesday, Wednesday...)
- Month (January, February, March, April, May...)
- Operator (&&, ||, ++, --, ==, !==, and, or...)
- ...

For example:

1. Increment

- `9` => `10`
- `aa99bb` => `aa100bb`
- `aa100bc` => `aa101bc`
- `0xDe` => `0xdf`
- `0Xdf` => `0Xe0`
- `0b101` => `0b110`
- `0B11` => `0B101`
- `true` => `false`
- `yes` => `no`
- `on` => `off`
- `T` => `F`
- `Fri` => `Sat`
- `Oct` => `Nov`
- `Monday` => `Tuesday`
- `January` => `February`
- `+` => `-`
- `++` => `--`
- `==` => `!=`
- `!==` => `===`
- `&&` => `||`
- `and` => `or`
- ...

2. Decrement:

- `100` => `99`
- `aa100bb` => `aa99bb`
- `0` => `-1`
- `0xdE0` => `0xDDF`
- `0xffFf0` => `0xfffef`
- `0xfffF0` => `0xFFFEF`
- `0x0` => `0xffffffffffffffff`
- `0Xf` => `0Xe`
- `0b100` => `0b010`
- `0B100` => `0B011`
- `True` => `False`
- `On` => `Off`
- `Sun` => `Sat`
- `Jan` => `Dec`
- `Monday` => `Sunday`
- `August` => `July`
- `/` => `*`
- `++` => `--`
- `==` => `!=`
- `!==` => `===`
- `||` => `&&`
- `or` => `and`
- ...
