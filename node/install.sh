#!/bin/sh

if test ! $(which nvm); then
    echo " Installing Nove Version Manager (NVM)"
    logfile="/tmp/nvm-install.log"
    if test $(which git); then
        git clone https://github.com/creationix/nvm.git $HOME/.nvm >> $logfile 2>&1
        echo "   Setting up NVM autoloading."
        echo "" >> $HOME/.bashrc
        echo '[[ -e "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh"' >> $HOME/.bashrc
        echo "   Activating bash completion."
        echo "" >> $HOME/.bashrc
        echo '[[ -r "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"' >> $HOME/.bashrc
    else
        echo "   You need to install dependencies: git"
    fi
fi
