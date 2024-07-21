# Docker minecraft with Ferium
Have you ever wonder to make dockerized modde minecraft, but without manually download and migrate all mod files one by one, but unable to do so?
Luckily, i experimented https://github.com/itzg/docker-minecraft-server with https://github.com/gorilla-devs/ferium, adjusting docker image, and **found a setup** that worked for me. Feel free to see the configuration and change it according to your needs.

## Setup
You need to prepare:
- An empty files folder besides `docker-compose.yaml`. This folder acts as your world files
- Download and install docker compose
  The, you can follow guides stated at https://github.com/itzg/docker-minecraft-server and https://github.com/gorilla-devs/ferium for respective config

Config explanation:
- `Dockerfile` contains command to download and setup mods
- `docker-compose.yaml` contains minecraft server setups and list of host folders included into the container
- `mod_config.json` contains ferium config to store all your mod list. This can be modified with ferium cli

## Execution
1. Make sure `files` folder has correct ownership
2. Change mod_config.json `output_dir` value to `/temp/mods`
3. Run `docker compose build mc` to build image and **download** the mods. If you want to add additional/ or modify/ or update mods in the future, run this command again
4. Run `docker compose up mc` to intiate it
