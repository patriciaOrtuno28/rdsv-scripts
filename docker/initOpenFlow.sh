#!/bin/bash

# Para activar OpenFlow version 1.3 en el bridge brint, porque sino se pone por defecto la v1.0:
echo "Definiendo version OpenFlow 1.3 ..."
ovs-vsctl set Bridge brint protocols=OpenFlow13

# Definir el puerto del manager de OpenFlow:
echo "Definiendo el puerto ptcp:6632 para el manager ..."
ovs-vsctl set-manager ptcp:6632

# Crear qos_simple_switch_13.py
echo "Creando qos_simple_switch_13.py ..."
sed '/OFPFlowMod(/,/)/s/)/, table_id=1)/' ryu/ryu/app/simple_switch_13.py > ryu/ryu/app/qos_simple_switch_13.py

# Instalar dependencias
echo "Instalando dependencias ..."
cd ryu/; python ./setup.py install
cd ..

# Para ejecutar la aplicacion Ryu:
echo "Ejecutando aplicacion Ryu qos_simple_switch_13.py ..."
ryu-manager ryu/ryu/app/rest_qos.py ryu/ryu/app/qos_simple_switch_13.py ryu/ryu/app/rest_conf_switch.py &

# Terminates the program (like Ctrl+C)
PID=$!
sleep 2
kill -INT $PID

# KNF access -> brgX : 12 Mbps bajada
# brgX -> KNF access : 6 Mbps subida
# Definir la ruta del manager
curl -X PUT -d '"tcp:127.0.0.1:6632"' http://localhost:8080/v1.0/conf/switches/0000000000000001/ovsdb_addr

# Crear una cola con QoS
# 12 Mbps como máximo para el enlace
# Cola 0 - hx1 : mínimo 8 Mbps
# Cola 1 - hx2 : máximo 4 Mbps
curl -X POST -d '{"port_name": "vxlanacc", "type": "linux-htb", "max_rate": "12000000", "queues": [{"min_rate": "8000000"}, {"max_rate": "4000000"}]}' http://localhost:8080/qos/queue/0000000000000001

# # Comprobar que la miss flow entry inicial se ha incluido a brint:
# echo "Tabla de flujos del bridge brint final ..."
# ovs-ofctl -O OpenFlow13 dump-flows brint
