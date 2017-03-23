#!/bin/sh

# automates steps 1-4, and first part of 5 (but NOT sub-steps of 5) on installation-instructions.md

# make sure the access token is an environment variable prior to running the script: `export GH_TOKEN=<token>`
# run the script like `sudo -E sh deployment-install.sh` with -E switch to preserve env vars

sudo apt-get update
sudo apt-get -y install curl git mysql-client libmysqlclient-dev
curl -L https://get.rvm.io | bash -s stable --ruby
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

# load rvm
source /home/ubuntu/.rvm/scripts/rvm
# load nvm
export NVM_DIR="/home/ubuntu/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

rvm install 2.3.1 && rvm use 2.3.1
nvm install node && nvm use node
gem update --system
gem install bundler
gem install rails -v 5.0.0.1

git clone https://${GH_TOKEN}@github.com/uva-slp/pauselab.git

cd pauselab/app
rvm 2.3.1
bundle install --deployment --without development test

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
sudo apt-get install -y apt-transport-https ca-certificates
sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'
sudo apt-get update
sudo apt-get install -y nginx-extras passenger
sudo service nginx start
