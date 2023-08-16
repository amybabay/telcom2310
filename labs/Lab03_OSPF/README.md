# FABRIC Educational Materials
# Tutorial: Open Shortest Path First
## Introduction
The goal of this tutorial is to understand how OSPF works and to allow the user to experiment with the protocol first hand on how it can be used in a network

## Running the Tutorial
- The tutorial has three Jupyter notebooks and one folder:
    - **CreateSlice.ipynb**: Creates the FABRIC slice/topology needed for this tutorial
    - **OSPF.ipynb**: Configures the IPv4/IPv6 network address, downloads the ospf software, and then begins the OSPF tutorial
    - **Assignment.ipynb**: Contains questions/tasks to be answered
- To run the tutorial:
   - Login to the FABRIC Portal and JupyterHub
    	- Login to the [FABRIC Portal](https://portal.fabric-testbed.net/)
    	- Login/connect to the [FABRIC JupyterHub](https://learn.fabric-testbed.net/knowledge-base/creating-your-first-experiment-in-jupyter-hub/)
   - Download the latest copy of the tutorials from GitHub
    	- Open a terminal in JupyterHub by clicking the "Terminal" tile under "Other" in the Launcher tab
    	- In the terminal window, type the following commands to download (pull) the latest version of the set of tutorials from Github
```
        	mkdir teaching-materials
        	cd teaching-materials
        	git clone https://github.com/fabric-testbed/teaching-materials.git
```

   - Run the Tutorial Notebooks
    	- In the left-hand column of JupyterHub, navigate to the OSPF tutorial
    	- Open and execute the CreateSlice.ipynb notebook
        - Then open and execute the OSPF.ipynb
        - Then open and execute the Assignment.ipynb

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
	- 100 disk space
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
