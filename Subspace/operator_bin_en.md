<p align="center">
  <img src="https://academy.autonomys.net/~gitbook/image?url=https%3A%2F%2F2323621046-files.gitbook.io%2F%7E%2Ffiles%2Fv0%2Fb%2Fgitbook-x-prod.appspot.com%2Fo%2Fspaces%252FDTGc8IP3S5s2AQxQdJti%252Flogo%252FaZjBRYLJxL42LxhxAsFi%252FAutonomys_RGB_Lockup_White.png%3Falt%3Dmedia%26token%3D0d553a35-8984-4c1b-801b-236804f34972&width=192&dpr=1&quality=100&sign=174f7f65&sv=1" alt="Autonomys Logo" width="192" />
</p>
<p align="center">
  <strong><span style="font-size: 2em;">Operator Automonys Setup Guide</span></strong>
</p>
![Screenshot 2024-06-28 at 21 48 28](https://github.com/luciolanguyen/Node/assets/105598260/036ea767-5e45-4c90-ad4b-cdaeb90a24a0)Hareware Requirement:
# Hardware requirement
## CPU:
- x86-64 compatible;
- Intel Ice Lake, or newer (Xeon or Core series); AMD Zen3, or newer (EPYC or Ryzen);
- 4 physical cores @ 3.4GHz;
- Simultaneous multithreading disabled (Hyper-Threading on Intel, SMT on AMD);
- Prefer single-threaded performance over higher cores count. A comparison of single-threaded performance can be found here.

## Storage:
- An NVMe SSD of 1 TB. In general, the latency is more important than the throughput.

## Memory:
- 32 GB DDR4 ECC.

## System:
- Linux Kernel 5.16 or newer.

## Network:
- The minimum symmetric networking speed is set to 500 Mbit/s.

# Installation 

## Update system 
```bash
sudo apt update && upgrade
```

## Download subspace binary running on ubuntu 22.04
```bash
mkdir subspace
cd $HOME/subspace
```
## Check CPU architecture 
```bash
grep -m1 'model name' /proc/cpuinfo
```
## CPU Skylake (CPU since 2015 ~ now) 
```bash
wget -O subspace-node https://github.com/subspace/subspace/releases/download/gemini-3h-2024-jun-18/subspace-node-ubuntu-x86_64-skylake-gemini-3h-2024-jun-18
```
## CPU Legacy (CPU since 2009 ~ old CPU)
```bash
wget -O subspace-node https://github.com/subspace/subspace/releases/download/gemini-3h-2024-jun-18/subspace-node-ubuntu-x86_64-v2-gemini-3h-2024-jun-18 
```
## CPU Aarch64/Rasberry Pi
```bash
wget -O subspace-node https://github.com/subspace/subspace/releases/download/gemini-3h-2024-jun-18/subspace-node-ubuntu-aarch64-gemini-3h-2024-jun-18
```
## Make it executable
```bash
chmod a+x subspace-*
mv subspace-* /usr/local/bin/
```
## Generate Domainkey
```bash
subspace-node domain key create --base-path /root/subspace/ --domain-id 0
```

## Register your operator 
[Link](https://explorer.subspace.network/gemini-3h/staking/register).
## Get your operator id

## Set Your Node Name 
```bash
NODE_NAME="YOUR_NAME"
OPERATOR_ID=YOUR_OPERATOR_ID
```

## Create systemD file
```bash
sudo tee /etc/systemd/system/subspace-operatord.service > /dev/null << EOF
[Unit]
Description=Subspace Operator Node
After=network-online.target
[Service]
User=root
ExecStart=/usr/local/bin/subspace-node run \\
  --chain gemini-3h \\
  --name $NODE_NAME \\
  --blocks-pruning archive-canonical \\
  --state-pruning archive-canonical \\
  --base-path /root/subspace/ -- --domain-id 0 --operator-id $OPERATOR_ID
Restart=on-failure
RestartSec=10
[Install]
WantedBy=multi-user.target
EOF
systemctl enable subspace-operatord
systemctl daemon-reload
systemctl restart subspace-operatord
```
## Check Log
```bash
journalctl -u subspace-operatord -f -o cat
```

**Note: You have to wait 2 or 3 days depending on your internet speed to get full synced**

#Here log after full synced
![Screenshot 2024-06-28 at 21 48 28](https://github.com/luciolanguyen/Node/assets/105598260/b1841a95-b0f4-4eae-be7b-17194926a12e)

1. Block height at consensus layer the same gemini-3h
2. Block height at EVM domain the same as gemini-3h Nova
3. Your operator pre-validating bundle transactions

#Delete node 
```bash
systemctl stop subspace-operatord
systemctl disable subspace-operatord
rm /etc/systemd/system/subspace-operatord.service
rm -r ~/subspace
```
<p align="center">
  <strong><span style="font-size: 2em;">End</span></strong>
</p>


