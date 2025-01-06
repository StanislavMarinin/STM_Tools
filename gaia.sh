#!/bin/bash

BOLD="\033[1m"
UNDERLINE="\033[4m"
DARK_YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RESET="\033[0;32m"

execute_with_prompt() {
    echo -e "${BOLD}Executing: $1${RESET}"
    if eval "$1"; then
        echo "Command executed successfully."
    else
        echo -e "${BOLD}${DARK_YELLOW}Error executing command: $1${RESET}"
        exit 1
    fi
}

execute_with_prompt "sudo apt update -y && sudo apt upgrade -y"

touch ~/g_setup.txt

execute_with_prompt "curl -sSfL 'https://github.com/GaiaNet-AI/gaianet-node/releases/latest/download/install.sh' | bash >> ~/g_setup.txt"

execute_with_prompt "source ~/.bashrc"

execute_with_prompt "gaianet init --config https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json >> ~/g_setup.txt"

execute_with_prompt "gaianet start >> ~/g_setup.txt"

execute_with_prompt ""

execute_with_prompt ""

execute_with_prompt ""
