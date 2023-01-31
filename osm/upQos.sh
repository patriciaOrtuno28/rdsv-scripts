#!/bin/bash

deployment_id() {
    echo `osm ns-list | grep $1 | awk '{split($0,a,"|");print a[3]}' | xargs osm vnf-list --ns | grep $2 | awk '{split($0,a,"|");print a[2]}' | xargs osm vnf-show --literal | grep name | grep $2 | awk '{split($0,a,":");print a[2]}' | sed 's/ //g'`
}

# Get KID
echo "Definiendo KID ..."
AUX=$(osm k8scluster-list | grep -o -P '.{0,0}microk8s-cluster.{0,39}')
KID=${AUX:19:42}
echo $KID

# Get OSMNS
echo "Definiendo OSMNS ..."
CMD=$(osm k8scluster-show --literal $KID | grep -A1 projects)
export OSMNS=${CMD:24:37}
echo $OSMNS

echo "Definiendo ACCPOD para renes1 ..."
OSMACC1=$(deployment_id renes1 "access")
VACC1="deploy/$OSMACC1"
if [[ ! $VACC1 =~ "helmchartrepo-accesschart"  ]]; then
    echo ""       
    echo "ERROR: incorrect <access_deployment_id>: $VACC1"
    exit 1
fi
echo $VACC1

echo "Definiendo ACCPOD para renes2 ..."
OSMACC2=$(deployment_id renes2 "access")
VACC2="deploy/$OSMACC2"
if [[ ! $VACC2 =~ "helmchartrepo-accesschart"  ]]; then
    echo ""       
    echo "ERROR: incorrect <access_deployment_id>: $VACC2"
    exit 1
fi
echo $VACC2

ACC_EXEC_1="kubectl exec -n $OSMNS $VACC1 --"
ACC_EXEC_2="kubectl exec -n $OSMNS $VACC2 --"

echo "Definiendo QoS de subida para renes1 ..."
# Definir la ruta del manager
$ACC_EXEC_1 curl -X PUT -d '"tcp:10.255.0.2:6632"' http://localhost:8080/v1.0/conf/switches/0000000000000001/ovsdb_addr
sleep 2

# Crear una cola con QoS
# 6 Mbps como máximo para el enlace
# Cola 0 - hx1 : máx 2 Mbps
# Cola 1 - hx2 : mín 4 Mbps
$ACC_EXEC_1 curl -X POST -d '{"port_name": "vxlanint", "type": "linux-htb", "max_rate": "6000000", "queues": [{"max_rate": "2000000"}, {"min_rate": "4000000"}]}' http://localhost:8080/qos/queue/0000000000000001

# Definir a que cola pertenece cada tráfico
$ACC_EXEC_1 curl -X POST -d '{"match": {"dl_src": "02:fd:00:04:01:01", "dl_type": "IPv4"}, "actions":{"queue": "0"}}' http://localhost:8080/qos/rules/0000000000000001
$ACC_EXEC_1 curl -X POST -d '{"match": {"dl_src": "02:fd:00:04:00:01", "dl_type": "IPv4"}, "actions":{"queue": "1"}}' http://localhost:8080/qos/rules/0000000000000001

echo "Definiendo QoS de subida para renes2 ..."
# Definir la ruta del manager
$ACC_EXEC_2 curl -X PUT -d '"tcp:10.255.0.4:6632"' http://localhost:8080/v1.0/conf/switches/0000000000000001/ovsdb_addr
sleep 2

# Crear una cola con QoS
# 6 Mbps como máximo para el enlace
# Cola 0 - hx1 : máx 2 Mbps
# Cola 1 - hx2 : mín 4 Mbps
$ACC_EXEC_2 curl -X POST -d '{"port_name": "vxlanint", "type": "linux-htb", "max_rate": "6000000", "queues": [{"max_rate": "2000000"}, {"min_rate": "4000000"}]}' http://localhost:8080/qos/queue/0000000000000001

# Definir a que cola pertenece cada tráfico
$ACC_EXEC_2 curl -X POST -d '{"match": {"dl_src": "02:fd:00:04:04:01", "dl_type": "IPv4"}, "actions":{"queue": "0"}}' http://localhost:8080/qos/rules/0000000000000001
$ACC_EXEC_2 curl -X POST -d '{"match": {"dl_src": "02:fd:00:04:03:01", "dl_type": "IPv4"}, "actions":{"queue": "1"}}' http://localhost:8080/qos/rules/0000000000000001
