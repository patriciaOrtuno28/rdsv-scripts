#!/bin/bash

# Para activar OpenFlow version 1.3 en el bridge brint, porque sino se pone por defecto la v1.0:
echo "Definiendo version OpenFlow 1.3 ..."
ovs-vsctl set Bridge brint protocols=OpenFlow13

# Para ver la lista inicialmente vacía de brint:
echo "Tabla de flujos del bridge brint inicial ..."
ovs-ofctl -O OpenFlow13 dump-flows brint

# Para ejecutar la aplicacion Ryu:
echo "Ejecutando aplicacion Ryu qos_simple_switch_13.py ..."
ryu-manager --verbose qos_simple_switch_13.py

# Comprobar que la miss flow entry inicial se ha incluido a brint:
echo "Tabla de flujos del bridge brint final ..."
ovs-ofctl -O OpenFlow13 dump-flows brint
