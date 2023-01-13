#!/bin/bash

# Asegurarse de que se han configurado las ips
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x dhclient_h11
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x dhclient_h12
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x dhclient_h21
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x dhclient_h22