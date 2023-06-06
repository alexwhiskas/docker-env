#!/bin/bash

echo "Sudo password might be requested to update vm.max_map_count param value."

sudo sysctl -w vm.max_map_count=262144
