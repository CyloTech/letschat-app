#!/bin/sh
set -x
/bin/sh /configmongo.sh

if [ ! -f /etc/app_configured ]; then
    echo "Installing Lets Chat"
    cd /data
    git clone https://github.com/sdelements/lets-chat.git
    cd /data/lets-chat
    npm install

    mkdir -p /data/uploads
    mv /settings.yml /data/lets-chat/settings.yml

    sed -i "s/DB_USER/${DB_USER}/g" /data/lets-chat/settings.yml
    sed -i "s/DB_PASS/${DB_PASS}/g" /data/lets-chat/settings.yml

cat << EOF >> /etc/supervisor/conf.d/letschat.conf
[program:letschat]
directory=/data/lets-chat
command=npm start
autostart=true
autorestart=true
priority=50
stdout_events_enabled=true
stderr_events_enabled=true
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
EOF

    touch /etc/app_configured

    #Tell Apex we're done installing.
    curl -i -H "Accept: application/json" -H "Content-Type:application/json" -X POST "https://api.cylo.io/v1/apps/installed/$INSTANCE_ID"
elseif
    cd /data/lets-chat
fi

echo "Sleeping for 10 seconds to give time for the database to come online"
sleep 10
#npm start &

echo "Starting MongoDB with Supervisor"
exec /usr/bin/supervisord -n -c /etc/supervisord.conf