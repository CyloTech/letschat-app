#!/bin/sh
/bin/sh /configmongo.sh

echo "Installing Lets Chat"
cd /
git clone https://github.com/sdelements/lets-chat.git
cd /lets-chat
npm install

echo "Starting MongoDB with Supervisor"
exec /usr/bin/supervisord -n -c /etc/supervisord.conf