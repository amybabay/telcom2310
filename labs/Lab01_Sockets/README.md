# Lab 1: Introduction to Client-Server Applications and Wide-Area Networks

## Notes

A couple things changed since the labs were last tested. In the Jupyter
notebooks, replace: `ens7` with `enp7s0` (I have also seen some VMs using
`enp6s0`).

Replace `~/work/fabric_config/fabric_sliver_key` with
`~/work/fabric_config/slice_key`.

## Objectives

In this lab, you will:

- Review and understand the code for simple client-server applications using TCP and UDP
- Run client-server applications over a wide-area network using the Fabric testbed
- Examine performance characteristics using an application-level “Ping” test program
- Bonus: modify TCP “Ping” program to compare non-persistent vs persistent connections

## Prerequisites

You must have your Fabric account and JupyterHub environment setup. Please see the [Fabric Setup](https://github.com/amybabay/telcom2310/blob/main/Fabric_Setup.md) for instructions.

## Running the Lab

- The lab has two Jupyter notebooks and one folder:
    - **CreateSlice.ipynb**: Creates the FABRIC slice/topology needed for this tutorial
    - **SocketLab.ipynb**: Gets slice info, uploads test programs to nodes, and contains instructions for running the lab

- To run the lab:
   - Login to the FABRIC Portal and JupyterHub
    	- Login to the [FABRIC Portal](https://portal.fabric-testbed.net/) and click the "JupyterHub" link. Or, you can directly go to: [FABRIC JupyterHub](https://jupyter.fabric-testbed.net/)

   - Download the latest copy of the tutorials from GitHub
    	- Open a terminal in JupyterHub by clicking the "Terminal" tile under "Other" in the Launcher tab
    	- In the terminal window, type the following command to download (pull) the latest version of the set of tutorials from Github:
            ```
            git clone https://github.com/amybabay/telcom2310.git
            ```

   - Run the lab notebooks
    	- In the left-hand column of JupyterHub, navigate to the Lab01_Sockets lab
    	- Open and execute the CreateSlice.ipynb notebook
        - Then open and execute the SocketLab.ipynb, filling out your Lab1.docx worksheet as you go.
