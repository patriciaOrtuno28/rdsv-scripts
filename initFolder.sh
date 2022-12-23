#!/bin/bash

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
cp ../nfv-lab/osm_renes2.sh .

# Clonar el repositorio repo-rdsv con las imágenes propias
git clone https://github.com/patriciaOrtuno28/repo-rdsv.git ~/shared/rdsv-final/repo-rdsv
