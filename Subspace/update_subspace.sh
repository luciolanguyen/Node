#!/bin/bash
sytemctl stop subspace-farmerd
systemctl stop subspace-noded 
rm /usr/local/bin/subspace-*
cd $HOME/subspace
wget -O subspace-node https://github.com/subspace/subspace/releases/download/gemini-3g-2023-oct-31/subspace-node-ubuntu-x86_64-skylake-gemini-3g-2023-oct-31
wget -O subspace-farmer https://github.com/subspace/subspace/releases/download/gemini-3g-2023-oct-31/subspace-farmer-ubuntu-x86_64-skylake-gemini-3g-2023-oct-31
cp subspace-* /usr/local/bin/

#check node and farm working correctly 
if systemctl is-active --quiet subspace-noded.service; then
  # If the service is active, print success message in green color
  echo -e "\e[32mSubspace node started successfully\e[0m"
else
  # If the service is not active, print failure message in red color
  echo -e "\e[31mSubspace node failed to start\e[0m"
fi
sleep 3
echo "#######################################################"
echo "journalctl -u subspace-noded -f --no-hostname | ccze -A"
echo "to check log"
echo "#######################################################"
