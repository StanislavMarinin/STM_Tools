#!/bin/bash
cp -r \/root\/elxnode \/root\/melxnode
sed -i 's/testnet-3/prod/g' "/root/melxnode/validator.env"
docker kill melixir
docker rm melixir
docker pull elixirprotocol/validator --platform linux/amd64
docker run -d --env-file /root/melxnode/validator.env --platform linux/amd64 -p 17691:17691 --restart unless-stopped --name melixir elixirprotocol/validator   
sudo docker logs elixir -f
