#!/bin/bash

# Definir las variables de entorno de los pods ACCESS y CPE
echo "Definiendo CPEPOD ..."
AUXCPE=$(kubectl -n $OSMNS get pods | grep helmchartrepo-cpechart-)
CPEPOD=${AUXCPE:0:50}
echo $CPEPOD

echo "Definiendo ACCPOD ..."
AUXACC=$(kubectl -n $OSMNS get pods | grep helmchartrepo-accesschart-)
ACCPOD=${AUXACC:0:53}
echo $ACCPOD

# Enseñar vxlanacc
kubectl -n $OSMNS exec -it $ACCPOD -- /bin/bash
