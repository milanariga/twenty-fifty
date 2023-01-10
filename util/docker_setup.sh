#!/bin/bash

# Installs the ruby dependencies
echo "Installing ruby dependencies"
bundle

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

sudo cp ngnix-configuration.conf /etc/nginx/sites-available/2050.conf
sudo ln -s /etc/nginx/sites-available/2050.conf /etc/nginx/sites-enabled/2050.conf
sudo unlink /etc/nginx/sites-enabled/default
sudo nginx -t
sudo service nginx restart

echo "The code should now be available on this computer"
