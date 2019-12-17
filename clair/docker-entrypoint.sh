#!/bin/sh -e


/usr/local/bin/envsubst < /etc/clair/config.yaml.tpl  > /etc/clair/config.yaml

case $1 in

  clair)
    /usr/bin/dumb-init -- /clair -config /etc/clair/config.yaml
  ;;

  *)
    exec "$@"
  ;;

esac

exit 0
