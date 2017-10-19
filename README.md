# Swarm Boilerplate

> Note:
> This is a work in progress, contributions are welcome

## What is this?

An effort to simplify deployments on docker swarm using existing opensource tools.

## Usage

1. Clone this repositiory on your docker swarm manager 
2. Run `./deploy.sh`. 

> Help Needed
> How to securely deploy on remote node in continous integration software (think travis, gitlab ci, et cetera)

You can add your own stack by creating an appropriately named folder and adding the `docker-compose.yml` file in there. 

You can also remove a stack by hiding it's folder. For example to remove the `whoami` stack, simply execute `mv whoami .whoami`. You could also just delete the folder. Don't forget to execute `./deploy.sh` to apply changes. 

## What's backed in?

### Traefik

Træfik is a "modern HTTP reverse proxy and load balancer made to deploy microservices with ease." I like the fact that they have built in integration with letsencrypt, that means free HTTPS. Yes that's right, I bet your bank account will love that.

### Watchtower

Watchtower watches a docker registry and updates your containers when a new image is released

### Portainer

With portainer, you don't have to log into your server just to do `docker exec` on a running container.

### Gitlab

Opensource version control and continous integration software. Also comes with inbuilt docker registry and tons more. 
