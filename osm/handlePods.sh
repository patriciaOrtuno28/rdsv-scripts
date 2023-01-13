#!/bin/bash

# Obtener el pod al que queremos acceder
while getopts p: flag
do
    case "${flag}" in
        p) pod=${OPTARG};;
    esac
done

# Definir la variable de entorno de un pod y acceder a este
if [[ $pod == "access" ]]
then 
    echo "Definiendo ACCPOD ..."
    AUXACC=$(kubectl -n $OSMNS get pods | grep helmchartrepo-accesschart-)
    ACCPOD=${AUXACC:0:53}
    echo $ACCPOD

    echo "Accediendo a ACCPOD ..."
    kubectl -n $OSMNS exec -it $ACCPOD -- /bin/bash

elif [[ $pod == "cpe" ]]
then
    echo "Definiendo CPEPOD ..."
    AUXCPE=$(kubectl -n $OSMNS get pods | grep helmchartrepo-cpechart-)
    CPEPOD=${AUXCPE:0:50}
    echo $CPEPOD

    echo "Accediendo a CPEPOD ..."
    kubectl -n $OSMNS exec -it $CPEPOD -- /bin/bash

else
    echo "Identificador de pod no válido ..."
fi