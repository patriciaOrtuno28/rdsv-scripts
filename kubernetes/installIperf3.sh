#!/bin/bash

cd /home/upm/shared/rdsv-final

# Instalar iperf3
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x iperf3_h11
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x iperf3_h12
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x iperf3_h21
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x iperf3_h22

sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x iperf3_brg1
sudo vnx -f vnx/nfv3_home_lxc_ubuntu64.xml -x iperf3_brg2

sudo vnx -f vnx/nfv3_server_lxc_ubuntu64.xml -x iperf3_s1
