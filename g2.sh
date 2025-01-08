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

execute_with_prompt "sudo apt update -y && sudo apt update"
execute_with_prompt "sudo apt install python3-pip -y"
execute_with_prompt "sudo apt install nano -y"
execute_with_prompt "sudo apt install screen -y"
execute_with_prompt "pip install requests"
execute_with_prompt "pip install faker"
execute_with_prompt "gaianet run"
WADR=$(sed -n 's/ *\"address\": \"\([^\"]*\)\".*/\1/p' /root/gaianet/nodeid.json)
execute_with_prompt "wget https://raw.githubusercontent.com/StanislavMarinin/STM_Tools/refs/heads/main/random_chat_with_faker.py"
execute_with_prompt "sed -i 's/wall/$WADR/g' random_chat_with_faker.py"
FCHAT="python3 ~/random_chat_with_faker.py"
execute_with_prompt "tmux new-session -d -s fakerchat bash -c \"${FCHAT}\""
