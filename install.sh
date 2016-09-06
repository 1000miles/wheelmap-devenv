#!/bin/bash
# Error out immediately if we get any errors, so we know things failed.
set -e

  #statements
#Set locale to en_US.utf8. Needed for a successful capistrano deployment
update-locale LC_ALL=en_US.utf8

apt-get update

# Enable the add-apt-repository command.
apt-get install -y software-properties-common

# We need MySQL 5.6 right now, but since it's not in Xenial package repositories, we need to have this one here in place
add-apt-repository 'deb http://archive.ubuntu.com/ubuntu trusty universe'

# Update apt once again so it learns about this new repo.
apt-get update

export DEBIAN_FRONTEND=noninteractive #Prevents mysql installer to show set password dialogue
export MYSQL_ROOT_PASSWORD='root'
debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server-5.6 mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"

apt-get install -y git imagemagick mysql-server-5.6 python-software-properties curl build-essential libmysqlclient-dev libxslt-dev libxml2-dev zlib1g-dev libmagick++-dev vim ruby ruby-dev nodejs npm
gem install bundler
