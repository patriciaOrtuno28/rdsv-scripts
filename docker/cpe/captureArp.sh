#!/bin/bash

echo ""
echo "Verificando proceso ARP en ejecucion ..."
ps -ef |grep arpwatch

echo ""
echo "Verificar tabla ARP actual: "
arp -a

echo ""
echo "Verificar tablas .dat: "
etc/init.d/arpwatch stop
sleep 2

echo ""
echo "Tabla brint.dat: "
cat /var/lib/arpwatch/brint.dat

etc/init.d/arpwatch start
etc/init.d/arpwatch status
