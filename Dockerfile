FROM ae9a7bf53c48

LABEL maintainer="Gavin Hanson <glow@cylo.io>"

RUN apk update && apk add nodejs \
    nodejs-npm \
    python \
    git

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /*.sh
RUN chmod +x /*.sh


CMD ["/entrypoint.sh"]