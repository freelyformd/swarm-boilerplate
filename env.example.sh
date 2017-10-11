#!/bin/sh

export DOMAIN=local
export PORTAINER_DOMAIN=portainer.${DOMAIN}
export TRAEFIK_UI_DOMAIN=proxy.${DOMAIN}
export CONSUL_UI_DOMAIN=consul.${DOMAIN}
export GITLAB_DOMAIN=gitlab.${DOMAIN}