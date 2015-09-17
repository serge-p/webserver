#!/bin/sh
yum -y install wget git 
mkdir -p /srv/salt # && cd /srv && git clone https://github.com/serge-p/webserver.git
wget -O install_salt.sh https://bootstrap.saltstack.com || curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh
echo "file_client: local" >/etc/salt/minion.d/masterless.conf
echo  

#!/bin/sh
yum -y install wget git 
mkdir -p /srv/salt # && cd /srv && git clone https://github.com/serge-p/webserver.git
wget -O install_salt.sh https://bootstrap.saltstack.com || curl -L https://bootstrap.saltstack.com -o install_salt.sh
sh install_salt.sh
echo "file_client: local" >/etc/salt/minion.d/masterless.conf
echo  

