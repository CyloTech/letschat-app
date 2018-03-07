#!/bin/sh
/bin/sh /configmongo.sh


if [ ! -f /etc/letschatinstalled ]; then
    echo "Installing Lets Chat"
    cd /data
    git clone https://github.com/sdelements/lets-chat.git
    cd /data/lets-chat
    npm install

    mkdir -p /data/uploads
    mv /settings.yml /data/lets-chat/settings.yml

    sed -i "s/DB_USER/${DB_USER}/g" /data/lets-chat/settings.yml
    sed -i "s/DB_PASS/${DB_PASS}/g" /data/lets-chat/settings.yml

    touch /etc/letschatinstalled
elseif
    cd /data/lets-chat
fi

npm start &

echo "Starting MongoDB with Supervisor"
exec /usr/bin/supervisord -n -c /etc/supervisord.conf