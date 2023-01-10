#!/bin/bash

# Create the server configuration file
twentyfiftyserverroot=$(pwd)/public
cat <<EndConf > ngnix-configuration.conf
server {
  listen 8080 default_server;
  listen [::]:8080 default_server ipv6only=on;
  root $twentyfiftyserverroot;

  passenger_enabled on;
}
EndConf

cp ngnix-configuration.conf /etc/nginx/sites-available/2050.conf
ln -sf /etc/nginx/sites-available/2050.conf /etc/nginx/sites-enabled/2050.conf
unlink /etc/nginx/sites-enabled/default
nginx -t
#service nginx restart

echo "The code should now be available on this computer"
