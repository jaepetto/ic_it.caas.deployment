declare -a IPS=(10.90.53.13 10.90.53.12 10.90.53.11 10.90.47.2 10.90.47.3 10.90.47.4 10.90.47.5 10.90.47.6 10.90.47.7 10.90.47.8 10.90.47.9 10.90.47.10 10.90.47.11 10.90.47.12 10.90.47.14 10.90.47.15 10.90.47.16 10.90.47.17 10.90.47.18 10.90.47.19 10.90.47.20 10.90.47.21 10.90.47.22 10.90.47.23 10.90.47.24 10.90.47.25 10.90.47.26 10.90.47.27 10.90.47.28 10.90.47.29 10.90.47.30 10.90.47.31 10.90.47.33 10.90.47.34 10.90.47.35 10.90.50.2 10.90.50.3 10.90.50.4 10.90.50.5 10.90.50.6 10.90.50.7 10.90.50.8 10.90.50.9 10.90.50.10 10.90.50.11 10.90.50.12 10.90.50.13 10.90.50.14 10.90.50.15 10.90.50.16 10.90.50.17 10.90.50.18 10.90.50.19 10.90.49.2 10.90.49.4 10.90.49.5 10.90.49.6 10.90.49.7 10.90.49.8 10.90.52.2 10.90.52.3 10.90.52.4 10.90.52.5 10.90.52.6 10.90.52.7 10.90.52.8 10.90.52.9 10.90.53.2 10.90.53.3 10.90.53.4 10.90.53.5 10.90.53.6 10.90.53.7 10.90.53.8 10.90.53.9)
CONFIG_FILE=inventory/ic-cluster/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}