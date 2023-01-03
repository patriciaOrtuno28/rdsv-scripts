#!/bin/bash

# Crear la carpeta de la P4 para obtener sus ficheros
cd ~/shared
git clone https://github.com/educaredes/nfv-lab.git

# Crear la carpeta base rdsv-final con los ficheros requeridos
mkdir -p ~/shared/rdsv-final
cd ~/shared/rdsv-final

cp -r ../nfv-lab/helm/ .
cp -r ../nfv-lab/img/ .
cp -r ../nfv-lab/pck/ .
cp -r ../nfv-lab/vnx/ .

cp ../nfv-lab/renes_start.sh .
cp ../nfv-lab/osm_renes_start.sh .
cp ../nfv-lab/osm_renes1.sh .
cp ../rdsv-scripts/folder/osm_renes2.sh .

# Clonar el repositorio repo-rdsv con las imágenes propias
if cd ~/shared/rdsv-final/repo-rdsv; then git pull; else git clone https://github.com/patriciaOrtuno28/repo-rdsv.git ~/shared/rdsv-final/repo-rdsv; fi
