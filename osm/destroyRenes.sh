#!/bin/bash

# Obtener el renes que hay que eliminar
while getopts r: flag
do
    case "${flag}" in
        r) renes=${OPTARG};;
    esac
done

# Borrar una instancia de renes
if [[ $renes == "1" ]]
then 
    echo "Deleting renes1 ..."
    osm ns-delete $NSID1
elif [[ $renes == "2" ]]
then
    echo "Deleting renes2 ..."
    osm ns-delete $NSID2
else
    echo "Deleting renes1 and renes2 ..."
    osm ns-delete $NSID1
    osm ns-delete $NSID1
fi

# echo "Deleting pods ..."
# kubectl delete -n $OSMNS deployment --all