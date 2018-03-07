FROM repo.cylo.io/alpine-mongo:latest

LABEL maintainer="Gavin Hanson <glow@cylo.io>"

RUN apk update && apk add nodejs \
    nodejs-npm \
    python \
    git

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /*.sh
RUN chmod +x /*.sh

ADD configs/settings.yml /settings.yml


CMD ["/entrypoint.sh"]