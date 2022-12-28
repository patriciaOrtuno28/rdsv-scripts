#!/bin/bash

echo "Deleting renes ..."
osm ns-delete renes1
osm ns-delete renes2

echo "Deleting pods ..."
kubectl delete -n $OSMNS deployment --all
