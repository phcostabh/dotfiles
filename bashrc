# Load all dotfiles
DOTFILES_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $DOTFILES_ROOT/bash/env
source $DOTFILES_ROOT/bash/config
source $DOTFILES_ROOT/bash/aliases
source $DOTFILES_ROOT/bash/git-prompt.sh
