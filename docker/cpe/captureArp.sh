#!/bin/bash

echo 'deb http://archive.ubuntu.com/ubuntu/ trusty main universe restricted multiverse' >> /etc/apt/sources.list
apt-get update

apt-get -f install sysv-rc-conf -y

sysv-rc-conf --level 35 arpwatch on

sed -i 's@INTERFACES=""@INTERFACES="net1 eth0 brint"@g' /etc/default/arpwatch

echo ""
echo "Configurando la direccion de correo electronico ..."
echo 'IFACE_ARGS="-m p.ortuno@alumnos.upm.es"' > /etc/arpwatch/net1.iface
echo 'IFACE_ARGS="-m p.ortuno@alumnos.upm.es"' > /etc/arpwatch/eth0.iface
echo 'IFACE_ARGS="-m p.ortuno@alumnos.upm.es"' > /etc/arpwatch/brint.iface

echo ""
echo "Iniciando el servicio ARP ..."
etc/init.d/arpwatch start

echo ""
echo "Verificando proceso ARP en ejecucion ..."
ps -ef |grep arpwatch

echo ""
echo "Verificar tabla ARP actual: "
arp -a
