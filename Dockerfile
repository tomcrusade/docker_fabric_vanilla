FROM itzg/minecraft-server
RUN mkdir /temp
WORKDIR /temp
RUN \
  wget https://github.com/gorilla-devs/ferium/releases/download/v4.7.0/ferium-linux-nogui.zip && \
  unzip -j ferium-linux-nogui.zip && \
  mv ferium mcferium && \
  chown minecraft:root mcferium && \
  chmod 775 mcferium
ADD mod_config.json mod_config.json
ARG INCLUDED_MODS
RUN rm -rf mods
RUN mkdir -p mods
RUN echo "\
    #!/bin/bash \n\
    mods=\"$INCLUDED_MODS\"    \n\
    separated_mods=\$(echo \$mods | tr ',' '\\\n') \n\
    for profileName in \$separated_mods \n\
    do \n\
      ./mcferium --config-file ./mod_config.json profile switch \$profileName \n\
      ./mcferium --config-file ./mod_config.json upgrade \n\
    done" >> download.sh
RUN chmod +x ./download.sh
RUN . ./download.sh
RUN echo "\
    #!/bin/bash \n\
    mods=\"$INCLUDED_MODS\"    \n\
    separated_mods=\$(echo \$mods | tr ',' '\\\n') \n\
    for profileName in \$separated_mods \n\
    do \n\
      profilePath=\$(./mcferium --config-file ./mod_config.json profile info | grep -oP '(?<=Output directory:)([^\\\n]+)' | xargs) \n\
      cd \$profilePath \n\
      cp -r * /temp/mods \n\
      cd .. \n\
    done" >> migrate.sh
RUN chmod +x ./migrate.sh
RUN . ./migrate.sh
RUN echo "#!/bin/sh               \n\
    rm -rf /data/mods             \n\
    mkdir -p /data/mods           \n\
    cp -r /temp/mods/* /data/mods \n\
    exec \"/start\"" >> ./start.sh
RUN chmod +x ./start.sh
WORKDIR /data
ENTRYPOINT [ "/temp/start.sh" ]
