#!/bin/sh

if test ! $(which ruby); then
    echo " Installing rbenv."
    echo "   Installing rbenv requirements."
    logfile="/tmp/rbenv-install.log"
    apt-get install zlib1g-dev libssl-dev libreadline-dev libyaml-dev \
        libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev --yes > $logfile

    echo "   Installing rbenv."
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv >> $logfile 2>&1
    echo $SUDO_USER
    chown -R $SUDO_USER ~/.rbenv/
fi
