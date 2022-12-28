#!/bin/bash

# Run as: source ./captureArp.sh

echo 'deb http://archive.ubuntu.com/ubuntu/ trusty main universe restricted multiverse' >> /etc/apt/sources.list
apt-get update

## TODO: Add -y flag
apt-get -f install sysv-rc-conf

alias chkconfig=sysv-rc-conf

chkconfig --level 35 arpwatch on

sed -i 's@INTERFACES=""@INTERFACES="net1"@g' /etc/default/arpwatch

/etc/init.d/arpwatch start

arpwatch -i net1

echo "Configurando la direccion de correo electronico ..."
echo 'IFACE_ARGS="-m patiortu@gmail.com"' > /etc/arpwatch/net1.iface

echo "Verificar tabla ARP actual: "
arp -a

#echo "Contenido inicial de net1.dat: "
#cat /var/lib/arpwatch/net1.dat
