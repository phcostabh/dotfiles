#!/bin/sh

if test ! $(which php); then
    echo " Installing PHPBrew."
    echo "   Installing PHPBrew requirements."
    logfile="/tmp/phpbrew-install.log"
    apt-get install autoconf automake curl build-essential \
        libxslt1-dev re2c libxml2-dev php5-cli bison libbz2-dev --yes > $logfile
    apt-get build-dep php5 --yes >> $logfile

    echo "   Installing PHPBrew."
    curl -o /tmp/phpbrew https://raw.github.com/c9s/phpbrew/master/phpbrew >> $logfile 2>&1
    chmod +x /tmp/phpbrew
    cp /tmp/phpbrew /usr/bin/phpbrew

    echo "   Setting up PHPBrew autoloading."
    echo "" >> $HOME/.bashrc
    echo "[[ -e \"$HOME/.phpbrew/bashrc\" ]] && . \"$HOME/.phpbrew/bashrc\"" >> $HOME/.bashrc
fi
