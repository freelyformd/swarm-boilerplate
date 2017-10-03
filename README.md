# deploymental

> Note:
> This is a work in progress. Use at your own risk

## What is this?

An effort to simplify deployments on docker swarm using existing opensource tools. Some of the tools we use include;

### traefik

We use traefik to provide an automated reverse proxy

### watchtower

To update our docker images when an image is updated

### consul

Consul stores static configuration for traefik. I suspect we'll be able to use it for more in the future

### portainer

Portainer provides an easy way to handle all
