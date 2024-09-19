#!/bin/bash
docker kill elixir
docker rm elixir
docker pull elixirprotocol/validator:v3 --platform linux/amd64
docker run -d --env-file /root/elxnode/validator.env --platform linux/amd64 -p 17690:17690 --restart unless-stopped --name elixir elixirprotocol/validator:v3
sudo docker logs elixir -f
