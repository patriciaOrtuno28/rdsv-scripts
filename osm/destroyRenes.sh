#!/bin/bash


echo "Borrando el repositorio de K8s ..."
osm repo-delete helmchartrepo

echo "Borrando renes1 y renes2 ..."
osm ns-delete $NSID1
osm ns-delete $NSID1

sleep 30

echo "Borrando el NS Package ..."
osm nspkg-delete renes

sleep 5

echo "Borrando los VNF Package ..."
osm nfpkg-delete accessknf
osm nfpkg-delete cpeknf

