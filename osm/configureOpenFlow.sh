#!/bin/bash

while getopts a:b:c:d: flag
do
    case "${flag}" in
        a) h11=${OPTARG};;
        b) h12=${OPTARG};;
        c) h21=${OPTARG};;
        d) h22=${OPTARG};;
    esac
done

deployment_id() {
    echo `osm ns-list | grep $1 | awk '{split($0,a,"|");print a[3]}' | xargs osm vnf-list --ns | grep $2 | awk '{split($0,a,"|");print a[2]}' | xargs osm vnf-show --literal | grep name | grep $2 | awk '{split($0,a,":");print a[2]}' | sed 's/ //g'`
}

if [[ $h11 == "" ]] || [[ $h12 == "" ]] || [[ $h21 == "" ]] || [[ $h22 == "" ]]
then
    echo "Se deben definir las IPs de las redes residenciales"
else
    # OpenFlow for renes1
    echo "Iniciando OpenFlow en renes1 ..."
    OSMACC1=$(deployment_id renes1 "access")
    VACC1="deploy/$OSMACC1"
    if [[ ! $VACC1 =~ "helmchartrepo-accesschart"  ]]; then
        echo ""       
        echo "ERROR: incorrect <access_deployment_id>: $VACC1"
        exit 1
    fi
    ACC_EXEC_1="kubectl exec -n $OSMNS $VACC1 --"
    $ACC_EXEC_1 ./initOpenFlow.sh -a $h11 -b $h12 &

    # OpenFlow for renes2
    echo "Iniciando OpenFlow en renes2 ..."
    OSMACC2=$(deployment_id renes2 "access")
    VACC2="deploy/$OSMACC2"
    if [[ ! $VACC2 =~ "helmchartrepo-accesschart"  ]]; then
        echo ""       
        echo "ERROR: incorrect <access_deployment_id>: $VACC2"
        exit 1
    fi
    ACC_EXEC_2="kubectl exec -n $OSMNS $VACC2 --"
    $ACC_EXEC_2 ./initOpenFlow.sh -a $h21 -b $h22 &
fi
