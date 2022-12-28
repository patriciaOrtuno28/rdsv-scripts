#!/bin/bash

# Get KID
echo "Definiendo KID ..."
AUX=$(osm k8scluster-list | grep -o -P '.{0,0}microk8s-cluster.{0,39}')
KID=${AUX:19:42}
echo $KID

# Get OSMNS
echo "Definiendo OSMNS ..."
CMD=$(osm k8scluster-show --literal $KID | grep -A1 projects)
export OSMNS=${CMD:24:37}
echo $OSMNS

# Acceso desde el PC anfitrión, user/pass: admin/admin
firefox 192.168.56.12 &

# Crear el repositorio k8
osm repo-add helmchartrepo https://patriciaOrtuno28.github.io/repo-rdsv --type helm-chart --description "RDSV"

# Onboarding
cd ~/shared/rdsv-final/pck
# VNF Package
echo "Inicio del onboarding ..."
osm nfpkg-create accessknf_vnfd.tar.gz
osm nfpkg-create cpeknf_vnfd.tar.gz

# NS Package
osm nspkg-create renes_ns.tar.gz
echo "Fin del onboarding ..."

# Crear NSID1
echo "Definiendo el NSID1 ..."
export NSID1=$(osm ns-create --ns_name renes1 --nsd_name renes --vim_account dummy_vim)
echo $NSID1

# Crear NSID2
echo "Definiendo el NSID2 ..."
export NSID2=$(osm ns-create --ns_name renes2 --nsd_name renes --vim_account dummy_vim)
echo $NSID2

# Moverse de nuevo a esta carpeta
cd ~/shared/rdsv-scripts

# Esperar a que se termine de crear el servicio renes
watch osm ns-list
