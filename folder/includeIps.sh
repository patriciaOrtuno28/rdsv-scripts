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

if [[ $h11 == "" ]] || [[ $h12 == "" ]] || [[ $h21 == "" ]] || [[ $h22 == "" ]]
then
    echo "Se deben definir las IPs de las redes residenciales"
else
    # Modify osm_renes1.sh
    echo "Incluyendo $h11 y $h12 a osm_renes1.sh ..."
    sed '/^osm_renes_start.*/i export HX1=$h11\nexport HX2=$h12' ~/shared/rdsv-scripts/folder/osm_renes1.sh

    # Modify osm_renes2.sh
    echo "Incluyendo $h21 y $h22 a osm_renes1.sh ..."
    sed '/^osm_renes_start.*/i export HX1=$h21\nexport HX2=$h22' ~/shared/rdsv-scripts/folder/osm_renes2.sh
fi