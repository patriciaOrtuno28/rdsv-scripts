#!/bin/bash

echo "Run on brint interface ..."
arpwatch -i brint -f brint.dat

echo "Start arpwatch ..."
etc/init.d/arpwatch start
etc/init.d/arpwatch status

echo ""
echo "Verificando proceso ARP en ejecucion ..."
ps -ef |grep arpwatch

echo ""
echo "Verificar tabla ARP actual: "
arp -a

echo ""
echo "Verificar tablas .dat: "
etc/init.d/arpwatch stop

echo ""
echo "Tabla brint.dat: "
cat /var/lib/arpwatch/brint.dat

etc/init.d/arpwatch start
etc/init.d/arpwatch status
