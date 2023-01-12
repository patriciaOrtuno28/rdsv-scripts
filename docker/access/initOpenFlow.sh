#!/bin/bash

while getopts a:b: flag
do
    case "${flag}" in
        a) hx1=${OPTARG};;
        b) hx2=${OPTARG};;
    esac
done

if [[ $hx1 == "" ]] || [[ $hx2 == "" ]]
then
    echo "Se deben definir las IPs de la red residencial"
else
    # Instalar dependencias necesarias
    echo "Instalando dependencias ..."
    cd ryu/
    pip install .
    cd ..

    # Para activar OpenFlow version 1.3 en el bridge brint, porque sino se pone por defecto la v1.0:
    echo "Definiendo version OpenFlow 1.3 ..."
    ovs-vsctl set Bridge brint protocols=OpenFlow13

    # Definir el puerto del manager de OpenFlow:
    echo "Definiendo propiedades del controller ..."
    ovs-vsctl set-manager ptcp:6632
    ovs-vsctl set-controller brint tcp:127.0.0.1:6633
    ovs-vsctl set bridge brint other-config:datapath-id=0000000000000001

    # Crear qos_simple_switch_13.py
    echo "Creando qos_simple_switch_13.py ..."
    sed '/OFPFlowMod(/,/)/s/)/, table_id=1)/' ryu/ryu/app/simple_switch_13.py > ryu/ryu/app/qos_simple_switch_13.py

    # Instalar dependencias
    echo "Instalando dependencias ..."
    cd ryu/; python3 ./setup.py install
    cd ..

    # Para ejecutar la aplicacion Ryu:
    echo "Ejecutando aplicacion Ryu qos_simple_switch_13.py ..."
    ryu-manager ryu/ryu/app/rest_qos.py ryu/ryu/app/qos_simple_switch_13.py ryu/ryu/app/rest_conf_switch.py &

    # Terminates the program (like Ctrl+C)
    PID=$!
    sleep 5
    kill -INT $PID

    # KNF access -> brgX : 12 Mbps bajada
    # brgX -> KNF access : 6 Mbps subida
    # Definir la ruta del manager
    curl -X PUT -d '"tcp:127.0.0.1:6632"' http://localhost:8080/v1.0/conf/switches/0000000000000001/ovsdb_addr
    sleep 2

    # Crear una cola con QoS
    # 12 Mbps como máximo para el enlace
    # Cola 0 - hx1 : mínimo 8 Mbps
    # Cola 1 - hx2 : máximo 4 Mbps
    curl -X POST -d '{"port_name": "vxlanacc", "type": "linux-htb", "max_rate": "12000000", "queues": [{"min_rate": "8000000"}, {"max_rate": "4000000"}]}' http://localhost:8080/qos/queue/0000000000000001

    # Definir a que cola pertenece cada tráfico
    curl -X POST -d '{"match": {"nw_dst": $hx1}, "actions":{"queue": "0"}}' http://localhost:8080/qos/rules/0000000000000001
    curl -X POST -d '{"match": {"nw_dst": $hx2}, "actions":{"queue": "1"}}' http://localhost:8080/qos/rules/0000000000000001
fi