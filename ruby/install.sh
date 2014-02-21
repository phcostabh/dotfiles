#!/bin/sh

if test ! $(which ruby); then
    echo " Installing rbenv."
    echo "   Installing rbenv requirements."
    logfile="/tmp/rbenv-install.log"
    apt-get install zlib1g-dev libssl-dev libreadline-dev libyaml-dev \
        libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev --yes > $logfile

    echo "   Installing rbenv."
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv >> $logfile 2>&1

    echo "   Installing ruby-build."
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build >> $logfile 2>&1

    echo "   Installing rbevn-gem-rehash."
    git clone https://github.com/sstephenson/rbenv-gem-rehash.git ~/.rbenv/plugins/rbenv-gem-rehash >> $logfile 2>&1

    echo "   Copy this content below to your ~/.bashrc"
    echo <<EOF
        # ---------------------------------------------------------------------------------------------------"
        # Ruby Version Manager - rbenv
        # ---------------------------------------------------------------------------------------------------"
        export PATH="\$HOME/.rbenv/bin:\$PATH"
        if [[ -e "\$HOME/.rbenv" ]]; then
            eval "\$(rbenv init -)"
        fi
EOF


    chown -R $SUDO_USER ~/.rbenv/
fi
