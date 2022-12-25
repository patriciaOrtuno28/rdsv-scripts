#!/bin/bash

cd ~/shared/rdsv-final

# Crear túneles desde Linux con ip link
cp ~/shared/rdsv-scripts/renes/renes_start.sh renes_start.sh

# Configurar renes1
chmod 777 osm_renes1.sh
./osm_renes1.sh

# Configurar renes2
chmod 777 osm_renes2.sh
./osm_renes2.sh
