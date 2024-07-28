setopt re_match_pcre
setopt HIST_IGNORE_DUPS

# Handle SIGHUP gracefully
trap "exit" HUP

if [ -t 1 ] && [ -z "$TMUX" ]; then
  tmux new-session -A -s TERMUX
fi
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto        # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 1

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  copypath
  dircycle
  extract
  fzf-tab
  git
  git-auto-fetch
  gitfast
  last-working-dir
  magic-enter
  per-directory-history
  web-search
  zoxide
  zsh-autosuggestions
  zsh-completions
  zsh-interactive-cd
  zsh-vi-mode
  zsh-syntax-highlighting
  zsh-history-substring-search
)


fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# User configuration
function zvm_config() {
  # Surround operating mode (verb->s->surround)
  ZVM_VI_SURROUND_BINDKEY='classic'
  # Always starting with insert mode for each command line
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  # Retrieve default cursor styles
  local icur=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)
  local ncur=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)
  local vcur=$(zvm_cursor_style $ZVM_VISUAL_MODE_CURSOR)
  local vlcur=$(zvm_cursor_style $ZVM_VISUAL_LINE_MODE_CURSOR)
  # Append your custom color for your cursor
  ZVM_INSERT_MODE_CURSOR=$icur'\e\e]12;#4fa6ed\a'
  ZVM_NORMAL_MODE_CURSOR=$ncur'\e\e]12;#98c379\a'
  ZVM_VISUAL_MODE_CURSOR=$vcur'\e\e]12;#c678dd\a'
  ZVM_VISUAL_LINE_MODE_CURSOR=$vlcur'\e\e]12;#c678dd\a'
  ZVM_VI_HIGHLIGHT_FOREGROUND=#cccccc
  ZVM_VI_HIGHLIGHT_BACKGROUND=#c678dd
  ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold,underline
  ZVM_TERM=xterm-256color
  ZVM_VI_EDITOR='nvim'
}
source $ZSH/oh-my-zsh.sh

# Hide Ctrl commands
# [[ -o interactive ]] && stty -echoctl

# export MANPATH="/usr/local/man:$MANPATH"


# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.zsh_aliases, instead of adding them here directly.

if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

if [ -f ~/.zprofile ]; then
    . ~/.zprofile
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -Uz compinit
# zstyle ':completion:*' menu select
#compdef nala

_nala_completion() {
  eval $(env _TYPER_COMPLETE_ARGS="${words[1,$CURRENT]}" _NALA_COMPLETE=complete_zsh nala)
}

compdef _nala_completion nala

ZSH_HIGHLIGHT_HIGHLIGHTERS+=(main brackets pattern cursor)

# pnpm
export PNPM_HOME="/data/data/com.termux/files/home/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Cargo Path
export CARGO_BIN="/data/data/com.termux/files/home/.cargo/bin/"
case ":$PATH:" in
  *":$CARGO_BIN:"*) ;;
  *) export PATH="$CARGO_BIN:$PATH" ;;
esac

# Enable EsLint flat config support for Eslint_d
# Comment out to use legacy config
export ESLINT_USE_FLAT_CONFIG=true
export ESLINT_D_LOCAL_ESLINT_ONLY=true

# bun
# export BUN_INSTALL="$HOME/.bun"
# case ":$PATH:" in
#   *":$BUN_INSTALL/bin:"*) ;;
#   *) export PATH="$BUN_INSTALL/bin:$PATH" ;;
# esac
# export PATH="$BUN_INSTALL/bin:$PATH"

# Go
export GOPATH=$HOME/go
case ":$PATH:" in
  *":$GOPATH/bin:"*) ;;
  *) export PATH="$GOPATH/bin:$PATH" ;;
esac

# Ruby
export PATH=$PATH:/data/data/com.termux/files/usr/lib/ruby/gems/3.2.0/bin
export PATH=$PATH:/data/data/com.termux/files/home/.local/share/gem/ruby/3.2.0/bin

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

ZLE_RPROMPT_INDENT=0

# Check if gh copilot command exists
if command -v gh > /dev/null && gh copilot > /dev/null 2>&1; then
  # GH Copilot Alias
  eval "$(gh copilot alias -- zsh)"
fi
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors '${(s.:.)LS_COLORS}'
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'logo-ls -AhD'
# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

export TMUX_FZF_LAUNCH_KEY="C-f"
function f() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		pushd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
