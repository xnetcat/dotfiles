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
antigen bundle zdharma/fast-syntax-highlighting

# Set theme
antigen theme fino

# Commit antigen configuration
antigen apply

source ~/.profile
source ~/.aliases

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
