#!/bin/bash


set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else
      #code that need to run only one time ....
        cd /var/www/platform-client
        #need to add .env file with the ushahidi-platform web location.BACKEND_URL=http://myapi.server/
        touch .env
        echo "BACKEND_URL=$PLATFORM" >> .env
        gulp build
        cp /var/www/platform-client/server/rewrite.htaccess /var/www/platform-client/server/www/.htaccess
        
        #needed for fix problem with ubuntu and cron
        update-locale 
        date > /etc/configured
fi
