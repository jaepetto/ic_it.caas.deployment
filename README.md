# Deployment of IC-Cluster CaaS

## Structure

The structure of the repository is as follows:

- 01_step_1_pre-setup: Contains the playbooks to prepare the environment for the deployment of the cluster.
- 02_step_2_Kubespray: Contains the playbooks to deploy the cluster (Kubespray).
- 03_step_3_post-setup: Contains the playbooks to configure the cluster after the deployment.

> [!NOTE]
> Each step has it's own virtual environment and requirements.txt file to accommodate the requirements of each step.

## Pre-setup

The pre-setup is installing the base OS configuration and the required packages for the deployment of the cluster.

### Requirements

You should have a virtual environment activated with the required packages installed.

```bash
cd 01_step_1_pre-setup
python -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

Please also note that ansible has it's own requirements.yml file that should be installed before running the playbooks.

```bash
ansible-galaxy install -r requirements.yml
```

### inventory

Please review the inventory file and make sure that the hosts are correct and the variables are set correctly.

A typical line in the inventory file looks like this:

```ini
iccluster204.iccluster.epfl.ch gpu=nvidia-a100 cpu_worker=false gpu_worker=true type=G10 containerd_dedicated_disk=/dev/nvme0n1 wipe_containerd_dedicated_disk=true
```

The variables are as follows:

- `gpu`: The type of GPU to be installed on the node. The possible values are `nvidia-a100`, `nvidia-tesla-t4`, `nvidia-tesla-v100`, `nvidia-tesla-p10`, ...
- `cpu_worker`: If the node should be a CPU worker node or not. The possible values are `true` or `false`.
- `gpu_worker`: If the node should be a GPU worker node or not. The possible values are `true` or `false`.
- `type`: The type of the node. The possible values are `None` (for master nodes), `S8` (for CPU worker nodes), `G9` (for GPU worker nodes), `G10` (for GPU worker nodes).
- `containerd_dedicated_disk`: The path to the dedicated disk for containerd. The possible values are `false` (for master nodes), `/dev/sdb` (for CPU worker nodes), `/dev/nvme1n1` (for GPU worker nodes).
- `wipe_containerd_dedicated_disk`: If the dedicated disk for containerd should be wiped or not.

> [!WARNING]
> It is strongly recommended not to wipe the dedicated disk for containerd if you have any data on it (i.e. if you are running the playbook on an existong cluster).

### Playbooks

Once you are confident that the inventory file is correct, you can run the playbooks.

```bash
ansible-playbook -i inventory/(prod|test) playbooks/main.yaml
```

## Kubespray

The Kubespray step is deploying the cluster using the Kubespray project. Please refer to the [Kubespray documentation](https://kubespray.io/#/) for more information.

## Post-setup

The post-setup is configuring the cluster after the deployment. It is installing the required Kubernetes objects to make the cluster ready for use.

### Requirements

You should have a virtual environment activated with the required packages installed.

```bash
cd 03_step_3_post-setup
python -m venv venv
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

Please also note that ansible has it's own requirements.yml file that should be installed before running the playbooks.

```bash
ansible-galaxy install -r requirements.yml
```

### inventory

A typical inventory file looks like this:

```ini
[prod]
icadmin011.iccluster.epfl.ch gpu=False master_node=True
icadmin012.iccluster.epfl.ch gpu=False master_node=True
icadmin014.iccluster.epfl.ch gpu=False master_node=True
iccluster150.iccluster.epfl.ch gpu=False master_node=False tag=S8
iccluster151.iccluster.epfl.ch gpu=False master_node=False tag=S8
```

> [!NOTE]
> Please note the group name. You will need it to run set a common variable for all the nodes in the group.

### group_vars

The group_vars file should contain the following variable: `nginx_ingress_controller_external_ip`. It should be set to the external IP of the nginx ingress controller. The possible values are `10.90.53.160` for the production cluster and `10.90.36.200` for the test cluster.

### Playbooks

Once you are confident that the inventory file is correct, you can run the playbooks.

```bash
ansible-playbook -i inventory/(prod|test) playbooks/main.yaml
```
