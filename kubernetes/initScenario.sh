#!/bin/bash

# Iniciar el escenario
cd /home/upm/shared/rdsv-final
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -t
sudo vnx -f vnx/nfv3_server_lxc_ubuntu64.xml -t