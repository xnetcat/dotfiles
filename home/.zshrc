# Load antigen
source /usr/share/zsh/share/antigen.zsh

# Use oh my zsh
antigen use oh-my-zsh

# Bundle plugins
antigen bundle git
antigen bundle docker
antigen bundle pip
antigen bundle python
antigen bundle vscode
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma-continuum/fast-syntax-highlighting

# Set theme
antigen theme fino

# Commit antigen configuration
antigen apply

source ~/.profile
source ~/.aliases
