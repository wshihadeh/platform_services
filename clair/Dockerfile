FROM quay.io/coreos/clair:v2.1.2

LABEL maintainer="AL-waleed Shihadeh <wshihadeh.test@gmail.com>"

ENV BUILD_DEPS="gettext"  \
    RUNTIME_DEPS="libintl"

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

RUN set -x && \
    apk add --update $RUNTIME_DEPS && \
    apk add --virtual build_deps $BUILD_DEPS &&  \
    cp /usr/bin/envsubst /usr/local/bin/envsubst && \
    apk del build_deps

COPY ./config.yaml.tpl /etc/clair/config.yaml.tpl

CMD ["clair"]
