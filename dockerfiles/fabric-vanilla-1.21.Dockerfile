FROM itzg/minecraft-server
RUN mkdir /temp
WORKDIR /temp
RUN \
  wget https://github.com/gorilla-devs/ferium/releases/download/v4.7.0/ferium-linux-nogui.zip && \
  unzip -j ferium-linux-nogui.zip && \
  mv ferium mcferium && \
  chown minecraft:root mcferium && \
  chmod 775 mcferium
ADD ../mod-configs/fabric-vanila-1.21.json mod_config.json
ARG CACHEBUST=1
RUN \
  mkdir -p mods && \
  ./mcferium --config-file /temp/mod_config.json upgrade
RUN cp -r mods /data/mods
WORKDIR /data
