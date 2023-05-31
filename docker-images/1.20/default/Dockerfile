FROM eclipse-temurin:17-jre-alpine

ARG directory=/mc

WORKDIR ${directory}

RUN set -x \
    && apk add curl --no-cache \
    && curl -O https://mediafilez.forgecdn.net/files/4550/856/DawnCraft+1.20+Serverpack.zip \
    && unzip DawnCraft+1.20+Serverpack.zip \
    && rm -f DawnCraft+1.20+Serverpack.zip \
    && curl -O https://maven.minecraftforge.net/net/minecraftforge/forge/1.18.2-40.2.1/forge-1.18.2-40.2.1-installer.jar \
    && java -jar forge-1.18.2-40.2.1-installer.jar --installServer \
    && rm -f forge-1.18.2-40.2.1-installer.* \
    && apk del curl

COPY entrypoint.sh .

RUN chmod +x entrypoint.sh

ENV XMS=2500M XMX=8G EULA=

EXPOSE 25565/TCP

VOLUME "${directory}/world"

ENTRYPOINT [ "./entrypoint.sh" ]

CMD ["./run.sh"]
