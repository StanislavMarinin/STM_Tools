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

#execute_with_prompt "gaianet init --config 'https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json'"

#execute_with_prompt "gaianet start"

execute_with_prompt "sudo tee /etc/systemd/system/gaianet.service << EOF
[Unit]
Description=Gaianet Node Service
After=network.target
[Service]
Type=forking
RemainAfterExit=true
ExecStart=/root/gaianet/bin/gaianet start
ExecStop=/root/gaianet/bin/gaianet stop
ExecStopPost=/bin/sleep 20
Restart=always
RestartSec=5
User=root
[Install]
WantedBy=multi-user.target
EOF"

execute_with_prompt "sudo systemctl daemon-reload"
execute_with_prompt "source ~/.bashrc"
execute_with_prompt "gaianet init --config 'https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json'"
#gaianet run
sudo systemctl restart gaianet.service
execute_with_prompt "gaianet info > gaia.txt"
#sudo systemctl status gaianet.service
#execute_with_prompt "journalctl -u gaianet.service -f"
#exceute_with_prompt "sudo apt install python3-pip -y"
sudo apt install python3-pip -y
execute_with_prompt "sudo apt install nano -y"
execute_with_prompt "sudo apt install tmux -y"
execute_with_prompt "pip install requests"
execute_with_prompt "pip install faker"
gaianet init --config 'https://raw.githubusercontent.com/GaiaNet-AI/node-configs/main/qwen2-0.5b-instruct/config.json'
gaianet run
WADR=$(sed -n 's/ *\"address\": \"\([^\"]*\)\".*/\1/p' /root/gaianet/nodeid.json)
execute_with_prompt "wget https://raw.githubusercontent.com/StanislavMarinin/STM_Tools/refs/heads/main/random_chat_with_faker.py"
execute_with_prompt "sed -i 's/wall/$WADR/g' random_chat_with_faker.py"
FCHAT="python3 ~/random_chat_with_faker.py"
execute_with_prompt "tmux new-session -d -s fakerchat bash -c \"${FCHAT}\""
echo "DONE" 
