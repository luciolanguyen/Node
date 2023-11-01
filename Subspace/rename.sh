#!/bin/bash
sytemctl stop subspace-farmerd
systemctl stop subspace-noded 
rm /usr/local/bin/subspace-*
cd $HOME/subspace
wget -O subspace-node https://github.com/subspace/subspace/releases/download/gemini-3g-2023-oct-31/subspace-node-ubuntu-x86_64-skylake-gemini-3g-2023-oct-31
wget -O subspace-farmer https://github.com/subspace/subspace/releases/download/gemini-3g-2023-oct-31/subspace-farmer-ubuntu-x86_64-skylake-gemini-3g-2023-oct-31
cp subspace-* /usr/local/bin/
systemctl status subspace-farmerd
sleep 5
systemclt status subspace-noded
sleep 5
