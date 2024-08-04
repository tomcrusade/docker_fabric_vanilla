# Docker minecraft with Ferium
Have you ever wonder to make dockerized modde minecraft, but without manually download and migrate all mod files one by one, but unable to do so?
Luckily, i experimented https://github.com/itzg/docker-minecraft-server with https://github.com/gorilla-devs/ferium, adjusting docker image, and **found a setup** that worked for me. Feel free to see the configuration and change it according to your needs.

## Setup
You need to prepare:
- An empty `files` folder besides `docker-compose.yaml`. This folder acts as your world files
- Download and install docker compose
- You can follow one of these 2 option on setting up your server
- To adjust env, edit `docker-compose.yaml` `services.mc.environment` key value, according to https://github.com/itzg/docker-minecraft-server
- To adjust mods, you can edit `mod_config.json` by using [ferium cli](https://github.com/gorilla-devs/ferium) (make sure to only contain 1 profile and `output_dir` value is `/temp/mods`)

Config explanation:
- `Dockerfile` contains command to download and setup mods
- `docker-compose.yaml` contains minecraft server setups and list of host folders included into the container
- `mod_config.json` contains ferium config to store all your mod list. This can be modified with [ferium cli](https://github.com/gorilla-devs/ferium)

## Execution
1. Make sure `files` folder has correct ownership
2. Run `docker compose build mc` to build image and **download** the mods. If you want to add additional/ or modify/ or update mods in the future, run this command again
3. Run `docker compose up mc` to intiate it
