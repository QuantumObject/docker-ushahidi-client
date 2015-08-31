#!/bin/bash

cd /var/www
git clone https://github.com/ushahidi/platform-client.git
git submodule update --init --recursive

cd /var/www/platform-client
npm install -g gulp
npm install
