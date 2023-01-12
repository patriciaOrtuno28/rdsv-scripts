#!/bin/bash

cd /home/upm/shared/rdsv-final
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -t
sudo vnx -f vnx/nfv3_server_lxc_ubuntu64.xml -t

# Asegurarse de que se han configurado las ips
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x dhclient_h11
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x dhclient_h12
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x dhclient_h21
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x dhclient_h22
