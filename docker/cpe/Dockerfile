FROM ubuntu:20.04
# variables to automatically install tzdata 
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Madrid
# install required packages
RUN apt-get clean
RUN apt-get update \
    && apt-get install -y \
    net-tools \
    traceroute \
    curl \
    iptables \
    inetutils-ping \
    nano \
    build-essential \
    bridge-utils \
    isc-dhcp-server \
    tcpdump \
    openvswitch-switch \
    openvswitch-common \
    iperf3 \
    iproute2 \
    vim \
    arpwatch

COPY vnx_config_nat /usr/bin/
COPY isc-dhcp-server /etc/default/isc-dhcp-server
COPY dhcpd.conf /etc/dhcp/dhcpd.conf 

COPY README.txt .
COPY captureArp.sh .

RUN echo 'deb http://archive.ubuntu.com/ubuntu/ trusty main universe restricted multiverse' >> /etc/apt/sources.list

RUN apt-get update
RUN apt-get -f install sysv-rc-conf -y
RUN sysv-rc-conf --level 35 arpwatch on

RUN sed -i 's@INTERFACES=""@INTERFACES="brint"@g' /etc/default/arpwatch

RUN echo 'IFACE_ARGS="-m p.ortuno@alumnos.upm.es"' > /etc/arpwatch/brint.iface
