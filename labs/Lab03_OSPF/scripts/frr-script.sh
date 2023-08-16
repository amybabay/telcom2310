#!/bin/bash
################################################################################
# Amy Babay: October 25, 2020
# Adapted from prior Quagga version from:
#   Ben Newton
#   University of North Carolina at Chapel Hill
#   October 2, 2014
################################################################################

# set up this network where each node is a router. 
#
#    A--10.1.4.2------10.1.4.1--D
#    |                          |
# 10.1.1.1                   10.1.3.2
#    |                          |
#    |                          |
# 10.1.1.2                   10.1.3.1
#    |                          |
#    B--10.1.2.1------10.1.2.2--C

DAEMONS="/etc/frr/daemons"
ZEBRA="/etc/frr/zebra.conf"
ZEBRA_TEMP="/tmp/zebra"
OSPFD="/etc/frr/ospfd.conf"
OSPFD_TEMP="/tmp/ospfd"
VTYSH_CONF="/etc/frr/vtysh.conf"
VTYSH_TEMP="/tmp/vtysh.conf"
FRR_CONF="/etc/frr/frr.conf"

# disable Static routes installed by GENI.
sudo /var/emulab/boot/rc.route disable-routes

# look for the ospfd conf file, and if it is there assume we are rebooting
# instead of booting the first time, therefore everything is already installed
# and configured, so skip.
if [[ ! -f $OSPFD ]]; then
    ########## INSTALL FRR (see: https://deb.frrouting.org/) ##########

    # add GPG key
    curl -s https://deb-us.frrouting.org/frr/keys.asc | sudo apt-key add -

    # possible values for FRRVER: frr-6 frr-7 frr-stable
    # frr-stable will be the latest official stable release
    FRRVER="frr-stable"
    echo deb https://deb-us.frrouting.org/frr $(lsb_release -s -c) $FRRVER | sudo tee -a /etc/apt/sources.list.d/frr.list

    # update and install FRR
    sudo apt update && sudo apt -y install frr frr-pythontools traceroute

    ########## SET UP CONFIGURATION FILES ##########

    #enable ospf daemon
    sudo cp $DAEMONS $DAEMONS.orig
    sudo sed -i -e 's/ospfd=no/ospfd=yes/g' $DAEMONS
    
    #determine hostname, IP addrs
    HOST=`hostname | awk -F'.' '{print $1}'`
    ETH1IP=`ip addr | grep inet | grep ens7 | awk -F " " '{print $2}'`
    ETH2IP=`ip addr | grep inet | grep ens8 | awk -F " " '{print $2}'`
    NET1=`echo $ETH1IP | sed -e 's/.\//0\//g'`
    NET2=`echo $ETH2IP | sed -e 's/.\//0\//g'`
    if [[ ${ETH1IP: -4: -3} == "1" ]]; then
        ROUTER_ID=${ETH1IP:: -3}
    else
        ROUTER_ID=${ETH2IP:: -3}
    fi
    
    # Write zebra config file
    sudo echo "! Zebra configuration file" >> $ZEBRA_TEMP
    sudo echo "hostname $HOST" >> $ZEBRA_TEMP
    sudo echo "interface lo" >> $ZEBRA_TEMP
    sudo echo " description loopback" >> $ZEBRA_TEMP
    sudo echo " ip address 127.0.0.1/8" >> $ZEBRA_TEMP
    sudo echo " ip forwarding" >> $ZEBRA_TEMP
    sudo echo "!" >> $ZEBRA_TEMP
    sudo echo "interface ens7" >> $ZEBRA_TEMP
    sudo echo " description ens7" >> $ZEBRA_TEMP
    sudo echo " ip address $ETH1IP" >> $ZEBRA_TEMP
    sudo echo " ip forwarding" >> $ZEBRA_TEMP
    sudo echo "!" >> $ZEBRA_TEMP
    sudo echo "interface ens8" >> $ZEBRA_TEMP
    sudo echo " description ens8" >> $ZEBRA_TEMP
    sudo echo " ip address $ETH2IP" >> $ZEBRA_TEMP
    sudo echo " ip forwarding" >> $ZEBRA_TEMP
    sudo echo "log file /var/log/frr/zebra.log" >> $ZEBRA_TEMP
    sudo mv $ZEBRA_TEMP $ZEBRA
    sudo chown frr $ZEBRA
    sudo chgrp frr $ZEBRA
    sudo chmod u=rw,g=r,o= $ZEBRA

    # Write OSPFD config file
    sudo echo "! OSPFD configuration file" >> $OSPFD_TEMP
    sudo echo "hostname $HOST" >> $OSPFD_TEMP
    sudo echo "interface ens7" >> $OSPFD_TEMP
    sudo echo "interface ens8" >> $OSPFD_TEMP
    sudo echo "router ospf" >> $OSPFD_TEMP
    sudo echo " ospf router-id $ROUTER_ID" >> $OSPFD_TEMP
    sudo echo " network $NET1 area 0" >> $OSPFD_TEMP
    sudo echo " network $NET2 area 0" >> $OSPFD_TEMP
    sudo echo "log file /var/log/frr/ospfd.log" >> $OSPFD_TEMP
    sudo mv $OSPFD_TEMP $OSPFD
    sudo chown frr $OSPFD
    sudo chgrp frr $OSPFD
    sudo chmod u=rw,g=r,o= $OSPFD

    # Move FRR_CONF so that frr will not try to use integrated configuration
    sudo mv $FRR_CONF $FRR_CONF.orig

    # Write vtysh conf file, disabling integrated conf mode
    sudo echo "! VTYSH configuration file" >> $VTYSH_TEMP
    sudo echo "hostname $HOST" >> $VTYSH_TEMP
    sudo echo "no service integrated-vtysh-config" >> $VTYSH_TEMP
    sudo mv $VTYSH_TEMP $VTYSH_CONF
    sudo chown frr $VTYSH_CONF
    sudo chgrp frrvty $VTYSH_CONF
    sudo chmod ug=rw,o= $VTYSH_CONF

    #append line to environment to ensure VTYSH works right
    sudo cp /etc/environment /tmp/environment
    sudo chmod ugo+rw /tmp/environment
    sudo echo "VTYSH_PAGER=more" >> /tmp/environment
    sudo mv /tmp/environment /etc/environment
    
    #restart frr to apply new configuration
    sudo systemctl restart frr
fi
