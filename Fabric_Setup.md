# Fabric Setup

Labs for Telcom 2310  will use the Fabric testbed:
[https://portal.fabric-testbed.net/](https://portal.fabric-testbed.net/)

## Registering

Follow the instructions here:
[https://learn.fabric-testbed.net/knowledge-base/signing-up-for-a-fabric-account/](https://learn.fabric-testbed.net/knowledge-base/signing-up-for-a-fabric-account/)

You should use your Pitt institutional login to register your account.

**Important:** You MUST respond to the FABRIC approval email **within 24 hours** to activate your account. You must also complete the second part of the instructions and **login to the FABRIC portal after receiving your approval email**. Otherwise, I will not be able to add you to the course project to give you access to the lab environment.

## Configure Your JupyterHub Environment

We will use Fabric\'s JupyterHub environment to reserve virtual
machines. To get to JupyterHub from the Fabric portal, you can click the
\"JupyterHub\" link. Or, you can directly go to:
[https://jupyter.fabric-testbed.net/](https://jupyter.fabric-testbed.net/)

See instructions here:
[https://learn.fabric-testbed.net/knowledge-base/creating-your-first-experiment-in-jupyter-hub/](https://learn.fabric-testbed.net/knowledge-base/creating-your-first-experiment-in-jupyter-hub/) for more details.

1\. In the file browser on the left side of the screen, you should see a
list of folders. Double-click to open the \"jupyter-examples-rel1.7.0\"
folder.

2\. Double-click on \"start-here.ipynb\"

3\. Click the \"Configure Environment\" link in the notebook (under \"Getting
Started\" heading and \"Setup Environment\" bullet)

4\. Follow the instructions in the notebook, running each cell to set up your environment. Be sure to edit the `project_id` variable as instructed.
- This should create two SSH keys: a Bastion Key and a Sliver Key. To confirm, navigate back to the top-level folder in the JupyterHub file browser (folder icon), then double-click on the \"fabric_config\" folder. It should contain files: `fabric_bastion_key`, `fabric_bastion_key.pub`, `slice_key`, `slice_key.pub`, `ssh_config`, and `fabric_rc`.

## (Optional) Finish Configuring Your Local SSH Environment

The above instructions will allow you to reserve and SSH into Fabric VMs
from the JupyterHub. If you would like to SSH into your VMs using your
local SSH client, a few more steps are needed.

1\. The \"Configure Environment\" notebook you used above will create files in
the `fabric_config` folder in your JupyterHub. Download all of these files and
save them in a known location on your local computer. I've saved mine in
`~/.ssh/fabric_config/`.

2\. Set the file permissions so that the Bastion private key is only readable by
your user. You can do this with the command:
`chmod 0600 ~/.ssh/fabric_config/fabric_bastion_key` if you saved the key in the `.ssh/fabric_config` directory.
If you chose another location, adjust the path accordingly (e.g. if you
saved it in a telcom2310 directory on your Desktop:
`chmod 0600 ~/Desktop/telcom2310/fabric_bastion_key`)

3\. Set the file permissions so that the Sliver private key is only readable by
your user. You can do this with the command:
`chmod 0600 ~/.ssh/fabric_config/slice_key` if you saved the key in the `.ssh/fabric_config` directory.
If you chose another location, adjust the path accordingly (e.g. if you
saved it in a telcom2310 directory on your Desktop:
`chmod 0600 ~/Desktop/telcom2310/fabric_bastion_key`)

4\. Edit the "ssh_config" file with the correct location for your bastion key.
Specifically, change the line: `IdentityFile
/home/fabric/work/fabric_config/fabric_bastion_key` to have the path to your
key (e.g. `IdentityFile ~/.ssh/fabric_config/fabric_bastion_key`
