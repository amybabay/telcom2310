# Fabric Setup

Labs for Telcom 2310  will use the Fabric testbed:
[https://portal.fabric-testbed.net/](https://portal.fabric-testbed.net/)

## Registering

**Important:** Accounts must be approved by a Fabric admin, which can
take a day or two. Please register **as soon as possible** to ensure
your account is ready before the first lab.

Follow the instructions here:
[https://learn.fabric-testbed.net/knowledge-base/signing-up-for-a-fabric-account/](https://learn.fabric-testbed.net/knowledge-base/signing-up-for-a-fabric-account/)

You should use your Pitt institutional login to register your account.

## Generating SSH Keys

To access Fabric VMs, you will need to generate two SSH keypairs: a
bastion key and a sliver key.

You can do this as follows:

1\. Go to
[https://portal.fabric-testbed.net/experiments#sshKeys](https://portal.fabric-testbed.net/experiments#sshKeys)

2\. Select the \"Bastion\" tab

3\. Under \"Name\" enter \"bastion_key\" (without quotes)

4\. Click the \"Generate\" button

5\. Download **both** the public and private keys. The private key will
be named \"bastion_key\", and the corresponding public key will be named
\"bastion_key.pub\". Be sure to save these somewhere on your computer
that you will be able to find them again (the .ssh directory is the
conventional choice, but any location is ok).

6\. Set the file permissions so that the private key is only readable by
your user. You can do this with the command:
`chmod 0600 ~/.ssh/mysshkey` if you saved the key in the .ssh directory.
If you chose another location, adjust the path accordingly (e.g. if you
saved it in a telcom2310 directory on your Desktop:
`chmod 0600 ~/Desktop/telcom2310/mysshkey`)

7\. Repeat the above steps to generate the sliver key. Select the
\"Sliver\" tab instead of \"Bastion\" and name the key
\"fabric_sliver_key\".

## Configure Your JupyterHub Environment

We will use Fabric\'s JupyterHub environment to reserve virtual
machines. To get to JupyterHub from the Fabric portal, you can click the
\"JupyterHub\" link. Or, you can directly go to:
[https://jupyter.fabric-testbed.net/](https://jupyter.fabric-testbed.net/)

See instructions here:
[https://learn.fabric-testbed.net/knowledge-base/creating-your-first-experiment-in-jupyter-hub/](https://learn.fabric-testbed.net/knowledge-base/creating-your-first-experiment-in-jupyter-hub/) for more details.

1\. In the file browser on the left side of the screen, you should see a
list of folders. Double-click to open the \"jupyter-examples-rel1.5.3\"
folder.

2\. Double-click on \"start-here.ipynb\"

3\. Click the \"Configure Environment\" link in the notebook (under
\"Setup Environment\")

4\. Follow the instructions in the notebook, editing the specified
variables and running each cell to set up your environment. Note: I
recommend using the \~/work/fabric_config directory to store all your
keys and your ssh config file.

## (Optional) Finish Configuring Your Local SSH Environment

The above instructions will allow you to reserve and SSH into Fabric VMs
from the JupyterHub. If you would like to SSH into your VMs using your
local SSH client, one more step is needed.

The \"Configure Environment\" notebook you used above will create a file
\"ssh_config\" in your JupyterHub. Download this file and save it in a
known location on your local computer. I recommend using the same
directory where you saved your SSH keys (I\'ve saved mine as
\~/.ssh/fabric_config).
