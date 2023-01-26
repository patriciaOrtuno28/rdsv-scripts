#!/bin/bash

# Obtener el pod al que queremos acceder
while getopts p:r: flag
do
    case "${flag}" in
        p) pod=${OPTARG};;
        r) renes=${OPTARG};;
    esac
done

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

# Definir la variable de entorno de un pod y acceder a este
if [[ $pod == "" || $renes == "" ]]
then
    echo "Se debe definir el tipo del pod y la instancia renes correspondiente."
elif [[ $pod == "access" ]]
then 

    if [[ $renes == 1 ]]
    then
        echo "Definiendo ACCPOD para renes1 ..."
        OSMACC1=$(deployment_id renes1 "access")
        VACC1="deploy/$OSMACC1"
        if [[ ! $VACC1 =~ "helmchartrepo-accesschart"  ]]; then
            echo ""       
            echo "ERROR: incorrect <access_deployment_id>: $VACC1"
            exit 1
        fi
        echo "Accediendo a ACCPOD [ID:  $VACC1] ..."
        kubectl -n $OSMNS exec -it $VACC1 -- /bin/bash
    else
        echo "Definiendo ACCPOD para renes2 ..."
        OSMACC2=$(deployment_id renes2 "access")
        VACC2="deploy/$OSMACC2"
        if [[ ! $VACC2 =~ "helmchartrepo-accesschart"  ]]; then
            echo ""       
            echo "ERROR: incorrect <access_deployment_id>: $VACC2"
            exit 1
        fi
        echo "Accediendo a ACCPOD [ID:  $VACC2] ..."
        kubectl -n $OSMNS exec -it $VACC2 -- /bin/bash
    fi

elif [[ $pod == "cpe" ]]
then
    
    if [[ $renes == 1 ]]
    then
        echo "Definiendo CPEPOD para renes1 ..."
        OSMCPE1=$(deployment_id renes1 "cpe")
        VCPE1="deploy/$OSMCPE1"
        if [[ ! $VCPE1 =~ "helmchartrepo-cpechart"  ]]; then
            echo ""       
            echo "ERROR: incorrect <cpe_deployment_id>: $VCPE1"
            exit 1
        fi
        echo "Accediendo a CPEPOD [ID:  $VCPE1] ..."
        kubectl -n $OSMNS exec -it $VCPE1 -- /bin/bash
    else
        echo "Definiendo CPEPOD para renes2 ..."
        OSMCPE2=$(deployment_id renes2 "cpe")
        VCPE2="deploy/$OSMCPE2"
        if [[ ! $VCPE2 =~ "helmchartrepo-cpechart"  ]]; then
            echo ""       
            echo "ERROR: incorrect <cpe_deployment_id>: $VCPE2"
            exit 1
        fi
        echo "Accediendo a CPEPOD [ID:  $VCPE2] ..."
        kubectl -n $OSMNS exec -it $VCPE2 -- /bin/bash
    fi

else
    echo "Identificador de pod o de instancia renes no válido ..."
fi