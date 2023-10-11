# Lab 2: Reliable Data Transfer

## Objectives

In this lab, you will:

- Review Python code for an implementation of Go-Back-N to perform reliable data transfer on top of UDP
- Run the Go-Back-N program to transfer a file over a wide-area network using the Fabric testbed
- Experimentally validate the relationship between window size and throughput discussed in lecture

## Prerequisites

You must have your Fabric account and JupyterHub environment setup. Please see
the [Fabric
Setup](https://github.com/amybabay/telcom2310/blob/main/Fabric_Setup.md) for
instructions.

## Running the Lab

- The lab has two Jupyter notebooks and one folder:
    - **CreateSlice.ipynb**: Creates the FABRIC slice/topology needed for this tutorial
    - **RDTLab.ipynb**: Gets slice info, uploads test programs to nodes, and contains instructions for running the lab

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
            git pull
            ```
        - Otherwise:
            - In the terminal window, type the following command to download
              (pull) the latest version of the set of tutorials from Github:
            ```
            git clone https://github.com/amybabay/telcom2310.git
            ```

   - Run the lab notebooks
    	- In the left-hand column of JupyterHub, navigate to the `Lab02_RDT` lab
    	- Open and execute the `CreateSlice.ipynb` notebook
        - Then open and execute the `RDTLab.ipynb`, filling out your `Lab2_Worksheet.docx` document as you go.
