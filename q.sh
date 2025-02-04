#!/bin/bash
apt update && apt upgrade -y
apt install curl iptables build-essential git wget jq make gcc nano tmux htop nvme-cli pkg-config libssl-dev libleveldb-dev libgmp3-dev tar clang bsdmainutils ncdu unzip llvm libudev-dev make protobuf-compiler -y
wget https://raw.githubusercontent.com/dominant-strategies/quai-gpu-miner/refs/heads/main/deploy_miner.sh
chmod +x deploy_miner.sh
./deploy_miner.sh
chmod +x output/quai-gpu-miner-nvidia
apt update && apt upgrade -y
./output/quai-gpu-miner-nvidia -U -P stratum://176.213.209.204:3333
