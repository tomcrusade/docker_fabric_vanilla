# Docker minecraft with Ferium
Have you ever wonder to make dockerized modded minecraft, without manually download and migrate all mod files one by one, but unable to do so?
Luckily, i succesfully experimented https://github.com/itzg/docker-minecraft-server with https://github.com/gorilla-devs/ferium, adjusting docker image, and **found a setup** that worked for me. Feel free to see the configuration and change it according to your needs.

## Setup
You need to prepare:
1. An empty `files` folder besides `docker-compose.yaml`. This folder acts as your world files
2. Download and install docker compose, make sure to able to run docker commands **without root**
3. Adjust server env as you seem fit, by editing `docker-compose.yaml` `services.mc` key values following https://github.com/itzg/docker-minecraft-server docs (be careful when deleting or adding `services.mc.volumes`, do not override `mods` folder)

### Option 2: using custom mods
After executing 3 setup steps above, do this:
1. Edit `mod_config.json` by using [ferium cli](https://github.com/gorilla-devs/ferium) (make sure to only put ONLY directory name into `output_dir`)
2. To include mod profile into the installation, list down profile name from `mod_config.json` to `services.mc.build.args.INCLUDED_MODS` in comma-separated value (ex: `mod-1,mod-2,mod-3` or  ex: `mod-1`)
3. Clear cache and run `docker compose build mc`

## Execution
1. Make sure `files` folder has correct ownership
2. (for Setup Option 2), Run `docker compose build mc` to build image and **download** the mods. If you want to update/modify mod list, clear cache and run this command again
3. Run `docker compose up mc` to initiate it

## Config explanation
- `Dockerfile` -> command to download and setup mods
- `docker-compose.yaml` contains minecraft server setups and list of host folders included into the container
- `mod_config.json` -> ferium config. This can be modified with [ferium cli](https://github.com/gorilla-devs/ferium)
