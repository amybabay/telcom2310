#!/bin/bash
################################################################################
# Ben Newton
# University of North Carolina at Chapel Hill
# October 2, 2014
################################################################################
#Modified for Fabric by Tristan Jordan
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

DAEMONS="/etc/quagga/daemons"
ZEBRA_SAMPLE="/usr/share/doc/quagga/examples/zebra.conf.sample"
ZEBRA="/etc/quagga/zebra.conf"
ZEBRA_TEMP="/tmp/zebra"
OSPFD_SAMPLE="/usr/share/doc/quagga/examples/ospfd.conf.sample"
OSPFD="/etc/quagga/ospfd.conf"
OSPFD_TEMP="/tmp/ospfd"

# disable Static routes installed by GENI.
sudo /var/emulab/boot/rc.route disable-routes


# look for this file, and if it is there assume we are rebooting instead of 
# booting the first time, therefore everything is alreay installed and 
# configured, so skip.
if [[ ! -f $OSPFD ]]; then
    #first update
    sudo apt-get update

    #install quagga and traceroute
    sudo apt-get -y install quagga traceroute

    #enable ospf daemon and zebra
    sudo cp $DAEMONS $DAEMONS.orig
    sudo sed -i -e 's/ospfd=no/ospfd=yes/g' -e 's/zebra=no/zebra=yes/g' $DAEMONS
    
    #determine first part of hostname
    HOST=`hostname | awk -F'.' '{print $1}'`
    ETH1IP=`ip addr | grep inet | grep ens7 | awk -F " " '{print $2}'`
    ETH2IP=`ip addr | grep inet | grep ens8 | awk -F " " '{print $2}'`
    NET1=`echo $ETH1IP | sed -e 's/.\//0\//g'`
    NET2=`echo $ETH2IP | sed -e 's/.\//0\//g'`
    
    
    #copy sample zebra config file and modify
    sudo sed -e 's/hostname Router/hostname '$HOST'/g' < $ZEBRA_SAMPLE > $ZEBRA_TEMP
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
    sudo echo "log file /var/log/quagga/zebra.log" >> $ZEBRA_TEMP
    sudo mv $ZEBRA_TEMP $ZEBRA

    #copy sample ospfd config file and modify
    sudo cp $OSPFD_SAMPLE $OSPFD_TEMP
    sudo chmod ugo+rw $OSPFD_TEMP
    sudo echo "interface ens7" >> $OSPFD_TEMP
    sudo echo "interface ens8" >> $OSPFD_TEMP
    sudo echo "router ospf" >> $OSPFD_TEMP
    sudo echo "network $NET1 area 0" >> $OSPFD_TEMP
    sudo echo "network $NET2 area 0" >> $OSPFD_TEMP
    sudo echo "log file /var/log/quagga/ospfd.log" >> $OSPFD_TEMP
    sudo mv $OSPFD_TEMP $OSPFD

    #copy sample vtysh config file
    sudo cp /usr/share/doc/quagga/examples/vtysh.conf.sample /etc/quagga/vtysh.conf
    
    #append line to environment to ensure VTYSH works right
    sudo cp /etc/environment /tmp/environment
    sudo chmod ugo+rw /tmp/environment
    sudo echo "VTYSH_PAGER=more" >> /tmp/environment
    sudo mv /tmp/environment /etc/environment
    
    #restart quagga
    sudo /etc/init.d/quagga restart
fi


