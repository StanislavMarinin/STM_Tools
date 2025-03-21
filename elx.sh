#!/bin/bash

sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo usermod -aG docker $USER

docker pull elixirprotocol/validator:3.1.0

docker run -d \
--env-file /root/elxnode/validator.env \
--name elixir \
--restart unless-stopped \
elixirprotocol/validator:3.1.0

docker run -it \
--env-file /root/elxnode/validator.env \
--name elixir \
elixirprotocol/validator:3.1.0

docker kill elixir
docker rm elixir
docker pull elixirprotocol/validator:v3 --platform linux/amd64
docker run -d --env-file /root/elxnode/validator.env --platform linux/amd64 -p 17690:17690 --restart unless-stopped --name elixir elixirprotocol/validator:v3
docker ps -a

