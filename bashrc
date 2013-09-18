# Load all dotfiles
source ~/bin/dotfiles/bash/env
source ~/bin/dotfiles/bash/config
source ~/bin/dotfiles/bash/aliases

# ---------------------------------------------------------------------------------------------------"
# Install NVM if it is not installed.
# ---------------------------------------------------------------------------------------------------"
if [[ ! -d "$NVM_HOME" ]]; then
    echo "Installing Node Version Manager - NVM"
    curl https://raw.github.com/creationix/nvm/master/install.sh | sh
fi

# Source NVM (with bash completion) if installed
[[ -f "$NVM_HOME/nvm.sh" ]] && source "$NVM_HOME/nvm.sh"
[[ -f "$NVM_HOME/bash_completion" ]] && source "$NVM_HOME/bash_completion" # NVM bash completion

# ---------------------------------------------------------------------------------------------------"
# Install RVM if it is not installed.
# ---------------------------------------------------------------------------------------------------"
if [[ ! -s "$RVM_HOME/scripts/rvm" ]]; then
    echo "Installing Ruvy Version Manager - RVM"
    curl -L https://get.rvm.io | bash -s stable --autolibs=enabled
fi

# Source RVM.
[[ -s "$RVM_HOME/scripts/rvm" ]] && source "$RVM_HOME/scripts/rvm"

# ---------------------------------------------------------------------------------------------------"
# Install PHPBrew
# ---------------------------------------------------------------------------------------------------"
if [[ ! -e /usr/bin/phpbrew ]]; then
    echo "Installing PHPBrew dependencies"
    sudo apt-get install autoconf automake curl build-essential libxslt1-dev re2c libxml2-dev \
        php5-cli bison libbz2-dev --yes > /dev/null
    sudo apt-get build-dep php5 --yes

    echo "Installing PHPBrew"
    curl -O https://raw.github.com/c9s/phpbrew/master/phpbrew
    chmod +x phpbrew
    sudo cp phpbrew /usr/bin/phpbrew
fi
