#!/bin/bash

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
