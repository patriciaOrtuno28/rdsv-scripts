#!/bin/bash

osm ns-delete renes1
osm ns-delete renes2

kubectl -n $OSMNS delete pods --all
