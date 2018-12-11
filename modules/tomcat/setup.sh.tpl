#!/bin/bash

LOGFILE=/tmp/terraform.log
TOMCAT_URL=http://apache.mirrors.ionfish.org/tomcat/tomcat-8/v8.5.35/bin/apache-tomcat-8.5.35.tar.gz

function timestamp {
  echo $(date "+%F %T")
}

function info {
  echo "$(timestamp) INFO:  $1" | tee -a "$${LOGFILE}"
}

function error {
  echo "$(timestamp) ERROR: $1" | tee -a "$${LOGFILE}"
}

info "VM created by Terraform"
IP_ADDRESS=$(/sbin/ip -f inet addr show dev ens160 | grep -Po 'inet \K[\d.]+')
info "My IP address is $${IP_ADDRESS}"

info "Installing Tomcat"
sudo apt-get update -y
sudo apt-get install -y default-jdk
sudo groupadd tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
cd /tmp
curl -O $TOMCAT_URL
sudo mkdir /opt/tomcat
sudo tar xzvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1

info "Configuring Tomcat"
cd /opt/tomcat
sudo chgrp -R tomcat /opt/tomcat
sudo chmod -R g+r conf
sudo chmod g+x conf
sudo chown -R tomcat webapps/ work/ temp/ logs/
sudo cp /tmp/tomcat.service /etc/systemd/system/tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat
sudo systemctl status tomcat --no-pager

info "Modifying Firewall"
sudo ufw allow 8080


info "Configuration script complete"
