# Docker minecraft with Ferium
Have you ever wonder to make dockerized modde minecraft, but without manually download and migrate all mod files one by one, but unable to do so?
Luckily, i succesfully experimented https://github.com/itzg/docker-minecraft-server with https://github.com/gorilla-devs/ferium, adjusting docker image, and **found a setup** that worked for me. Feel free to see the configuration and change it according to your needs.

## Setup
You need to prepare:
1. An empty `files` folder besides `docker-compose.yaml`. This folder acts as your world files
2. Download and install docker compose, make sure to able to run docker commands **without root**
3. Adjust server env as you seem fit, by editing `docker-compose.yaml` `services.mc` key values following https://github.com/itzg/docker-minecraft-server docs (be careful on deleting or adding `services.mc.volumes`)
4. Follow ONLY ONE of these option:

### Option 1: Using our prebuild images & selected mods
Change `docker-compose.yaml`, `services.mc.image` value to one of below:
- `tomcrusade/minecraft-server-fabric-vanilla-1.21:latest` -> 1.21 fabric, but client does not need to install any mod

### Option 2: using custom mods
- Change `docker-compose.yaml`, remove `services.mc.image`, and replace it with `services.mc.build.dockerfile` with `./dockerfiles/fabric-vanilla-1.21.Dockerfile` as value
- To adjust mods, edit `mod-configs/fabric-vanilla-1.21.json` by using [ferium cli](https://github.com/gorilla-devs/ferium) (make sure to only contain 1 profile and `output_dir` value is `/temp/mods`)

## Execution
1. Make sure `files` folder has correct ownership
2. (for Setup Option 2), Run `docker compose build mc` to build image and **download** the mods. If you want to update/modify mod list, run this command again
3. Run `docker compose up mc` to initiate it

## Config explanation
- Files inside `dockerfile` contains command to download and setup mods of specific minecraft version per file
- `docker-compose.yaml` contains minecraft server setups and list of host folders included into the container
- Files inside `mod_configs` contains ferium config of specific minecraft version per file. This can be modified with [ferium cli](https://github.com/gorilla-devs/ferium)
