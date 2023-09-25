#!/data/data/com.termux/files/usr/bin/bash
# Install script for My Termux Dotfiles
# Set custom variables
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}
RED=$'\e[31m'
GREEN=$'\e[32m'
YELLOW=$'\e[33m'
ENDCOLOR=$'\e[0m'

function error_exit {
  echo -e "${RED}Error: $1${ENDCOLOR}" >&2
  exit 1
}

# Set Up Storage
termux-setup-storage

# Set up GitHub auth
gh auth login || error_exit "${RED}Failed to set up GitHub auth.${ENDCOLOR}"

# Set Up Git Credentials
echo -e "${YELLOW}Time to set up your Git credentials!${ENDCOLOR}"

# Prompt the user for their Git username
read -rp "${GREEN}Enter your Git username${ENDCOLOR}: " username

# Prompt the user for their Git email
read -rp "${GREEN}Enter your Git email${ENDCOLOR}: " email

# Prompt the user to choose between global and system-wide configuration
read -rp "${GREEN}Would you like to set your Git configuration system-wide? (Yes/No)${ENDCOLOR}: " choice

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


echo -e "${GREEN}Time to install Nala Package Manager, Zsh, Termux Clipboard, Neovim, NodeJS, Python-pip, Ruby, wget, logo-ls, Timewarrior, Taskwarrior, and htop!${ENDCOLOR}"
sleep 5

# Install Nala Package Manager, Z Shell, Termux Clipboard, Git, GitHub CLI, Neovim, NodeJS, Python-pip, Ruby, wget, logo-ls, Timewarrior, Taskwarrior, htop
apt update && apt upgrade -y || error_exit "${RED}Failed to update packages.${ENDCOLOR}"
apt update && apt install nala -y
nala install zsh termux-api gh neovim nodejs python-pip ruby wget logo-ls timewarrior taskwarrior htop -y || error_exit "${RED}Failed to install packages.${ENDCOLOR}"

# Install pynvim, pnpm and neovim npm package, and neovim gem package
python -m pip install pynvim || error_exit "${RED}Failed to install pynvim.${ENDCOLOR}"
npm install -g pnpm neovim || error_exit "${RED}Failed to install neovim npm package.${ENDCOLOR}"
gem install neovim || error_exit "${RED}Failed to install neovim gem package.${ENDCOLOR}"
gem update --system || error_exit "${RED}Failed to update gem.${ENDCOLOR}"

# Install MOTD
echo "${GREEN}Installing MOTD${ENDCOLOR}"
sleep 2
rm /data/data/com.termux/files/usr/etc/motd
git clone https://github.com/GR3YH4TT3R93/termux-motd.git /data/data/com.termux/files/usr/etc/motd
echo "/data/data/com.termux/files/usr/etc/motd/init.sh" >> /data/data/com.termux/files/usr/etc/zprofile

# Install Oh My Zsh
echo "${GREEN}Installing Oh-My-Zsh${ENDCOLOR}"
sleep 2
sh -c "$(curl -fsSL https://raw.githubusercontent.com/GR3YH4TT3R93/ohmyzsh/master/tools/install.sh)"

# Clean up excess files
rm ".shell.pre-oh-my-zsh"

# Install Powerlevel10k
echo -e "${GREEN}Installing Powerlevel10k${ENDCOLOR}"
sleep 2
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k" || error_exit "${RED}Failed to install Powerlevel10k.${ENDCOLOR}"

# Install Oh My Zsh plugins
echo -e "${GREEN}Time to choose your Zsh plugins!${ENDCOLOR}"
sleep 2
# Ask if user wants to install zsh plugins

# Auto-Suggestions
read -rp "${YELLOW}Would You Like Auto-Suggestions? (Yes/No)${ENDCOLOR}: " suggestions

if [[ "$suggestions" == [Yy]* ]]; then
  echo -e "${GREEN}Installing Zsh Auto-Suggestions${ENDCOLOR}"
  sleep 1
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || error_exit "${RED}Failed to install zsh-autosuggestions.${ENDCOLOR}"
else
  echo "${YELLOW}Skipping${ENDCOLOR}"
  sed -i '/zsh-auto-suggestions/d' ~/.zshrc
fi

# Completions
read -rp "${YELLOW}How about completions? (Yes/No)${ENDCOLOR}: " completions

if [[ "$completions" == [Yy]* ]]; then
  echo -e "${GREEN}Installing Zsh Completions${ENDCOLOR}"
  sleep 1
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions" || error_exit "${RED}Failed to install zsh-completions.${ENDCOLOR}"
else
  echo "${YELLOW}Skipping${ENDCOLOR}"
  sed -i '/zsh-completions/d' ~/.zshrc
fi

# History Substring Search
read -rp "${YELLOW}History Substring Search? (Yes/No)${ENDCOLOR}: " substring

if [[ "$substring" == [Yy]* ]]; then
  echo -e "${GREEN}Installing History Substring Search${ENDCOLOR}"
  sleep 1
  git clone https://github.com/zsh-users/zsh-history-substring-search "$ZSH_CUSTOM/plugins/zsh-history-substring-search" || error_exit "${RED}Failed to install zsh-history-substring-search.${ENDCOLOR}"
else
  echo "${YELLOW}Skipping${ENDCOLOR}"
  sed -i '/zsh-history-substring-search/d' ~/.zshrc
fi

# Syntax Highlighting
read -rp "${YELLOW}Syntax Highlighting? (Yes/No)${ENDCOLOR}: " highlighting
if [[ "$highlighting" == [Yy]* ]]; then
  echo -e "${GREEN}Installing Syntax Highlighting${ENDCOLOR}"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || error_exit "${RED}Failed to install zsh-syntax-highlighting.${ENDCOLOR}"
else
  echo "${YELLOW}Skipping${ENDCOLOR}"
  sed -i '/zsh-syntax-highlighting/d' ~/.zshrc
fi

read -rp "${GREEN}Git Flow Completions? (Yes/No)${ENDCOLOR}: " git
# Git Flow Completions
if [[ "$git" == [Yy]* ]]; then
  echo -e "${GREEN}Installing Git Flow Completions${ENDCOLOR}"
  sleep 1
  git clone https://github.com/bobthecow/git-flow-completion "$ZSH_CUSTOM/plugins/git-flow-completion" || error_exit "${RED}Failed to install git-flow-completion.${ENDCOLOR}"
else
  echo "${YELLOW}Skipping${ENDCOLOR}"
  sed -i '/git-flow-completions/d'
fi

# Zsh Vi Mode
read -rp "${YELLOW}Zsh Vi Mode? (Yes/No)${ENDCOLOR}: " vi
if [[ "$vi" == [Yy]* ]]; then
  echo -e "${GREEN}Installing Zsh Vi Mode${ENDCOLOR}"
  sleep 1
  git clone https://github.com/jeffreytse/zsh-vi-mode "$ZSH_CUSTOM/plugins/zsh-vi-mode" || error_exit "${RED}Failed to install zsh-vi-mode.${ENDCOLOR}"
else
  echo "${YELLOW}Skipping${ENDCOLOR}"
  sed -i '/zsh-vi-mode/d'
fi

# Magic Enter
read -rp "${YELLOW}Magic Enter? (Yes/No)${ENDCOLOR}: " magic
if [[ "$magic" == [Yy]* ]]; then
  echo -e "${GREEN}Installing Magic-Enter${ENDCOLOR}"
  sleep 1
  git clone https://github.com/GR3YH4TT3R93/magic-enter "$ZSH_CUSTOM/plugins/magic-enter" || error_exit "${RED}Failed to install magic-enter.${ENDCOLOR}"
else
  echo "${YELLOW}Skipping${ENDCOLOR}"
  sed -i '/magic-enter/d'
fi
# Hide README.md
file_path="$HOME/GitHub/dotfiles"

# Check if the file exists and is readable
if [ -e "$file_path" ]; then
  if [ -r "$file_path" ]; then
    echo "${GREEN}Hiding README.md in ~/.termux ${ENDCOLOR}"
    echo "${GREEN}moving...${ENDCOLOR}"
    git --git-dir="$HOME/GitHub/dotfiles" --work-tree="$HOME" mv README.md ~/.termux/README.md || error_exit "${RED}Failed to hide README.md.${ENDCOLOR}"
  else
    echo "${RED}File exists but is not readable. Cannot execute Git command.${ENDCOLOR}"
  fi
else
  echo "${YELLOW}Deletinging README.md and .git folder ${ENDCOLOR}"
  echo "${GREEN}Removing...${ENDCOLOR}"
  rm -rf README.md .git || error_exit "${RED}Failed to hide README.md.${ENDCOLOR}"
fi

# Finish Setup
echo -e "${GREEN}Setup Complete! Press Ctrl+D for changes to take effect.${ENDCOLOR}"
