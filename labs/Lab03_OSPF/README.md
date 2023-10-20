# Lab 3: Routing with OSPF

## Objectives

The goal of this tutorial is to understand how OSPF works and to experiment with the protocol first hand on how it can be used in a network.

## Prerequisites

You must have your Fabric account and JupyterHub environment setup. Please see
the [Fabric
Setup](https://github.com/amybabay/telcom2310/blob/main/Fabric_Setup.md) for
instructions.

## Running the Lab

- The lab has two Jupyter notebooks and one folder:
    - **CreateSlice.ipynb**: Creates the FABRIC slice/topology needed for this tutorial
    - **OSPF.ipynb**: Configures the IPv4/IPv6 network address, downloads the OSPF software, and contains instructions for running the lab 

- To run the lab:
   - Login to the FABRIC Portal and JupyterHub
    	- Login to the [FABRIC Portal](https://portal.fabric-testbed.net/)
    	- Login/connect to the [FABRIC JupyterHub](https://learn.fabric-testbed.net/knowledge-base/creating-your-first-experiment-in-jupyter-hub/)
   - Download the latest copy of the tutorials from GitHub
    	- Open a terminal in JupyterHub by clicking the "Terminal" tile under "Other" in the Launcher tab
        - If you already have a clone of the telcom2310 repo in your JupyterHub
          environment:
            - In the terminal, type the following to update to the latest version:
            ```
            cd telcom2310
            git fetch
            git pull
            ```
        - Otherwise:
            - In the terminal window, type the following command to download
              (pull) the latest version of the set of tutorials from Github:
            ```
            git clone https://github.com/amybabay/telcom2310.git
            ```

   - Run the lab notebooks
    	- In the left-hand column of JupyterHub, navigate to the `Lab03_OSPF` lab
    	- Open and execute the `CreateSlice.ipynb` notebook
        - Then open and execute the `OSPF.ipynb` notebook filling out your `Lab03_Worksheet.docx` document as you go.

## Overview of the Notebooks in this Tutorial

### Create Slice Notebook
- In this notebook you will request a slice that contains four nodes (ND_A, ND_B, ND_C, and, ND_D) and Four Layer-2 networks (LANs) with the following configurations:
```
	ND_A <-> lAN 2 <-> ND_B
	|            	    |
	lAN 1           	lAN 3
	|            	    |
	ND_C <-> lAN 4 <-> ND_D

```
- Each node should have the following requirements:
	- NIC_Basic model
	- "default_ubuntu_20" image
	- 1 cores
	- 4 ram
	- 10 disk space
 - To successfully run this notebook you should only need to run the code blocks in order from top to bottom
 - **Notes:** If your slice creation fails you can just try to specify a site in the second code block run them again. (you can get a site from "https://portal.fabric-testbed.net/" by looking at the map, use the name **outside** of the parenthesis and make sure the site chosen is up)

### OSPF Notebook
- To successfully run this notebook you need to run the code blocks first (*Setup Experiment*) and then run the experiment (*Run Experiment*):
	- Setup Experiment: This is the setup, run the provided Codeblocks to setup the network and to provide the correct addresses to each node.
    - Run Experiment: This is the Experiment, To complete this section just follow the provided instructions to understand the 3 capabilities in this tutorial: Router Interface, Dead Link and Route Change.
 
### Assignment Notebook
- In this Assignment you will attempt to test how this algorithm can be tricked into sending route errors, and experiment with the 'hello' & 'dead' intervals to answer some questions
- **Notes:** In the case the slice fails to delete please examine the experiment tab on the fabric portal and delete the corresponding slice if it was not already deleted

## Additional Information
- FABRIC Learn Website: If you encounter problems,questions, or suggestions, please navigate to the FABRIC Knowledge Base at https://learn.fabric-testbed.net/
- FABRIC Teaching Material Github: <https://github.com/fabric-testbed/teaching-materials>
- This assignment was originally written for the GENI network (<https://www.cs.unc.edu/Research/geni/geniEdu/06-Ospf.html>), but has been converted to run in FABRIC.
