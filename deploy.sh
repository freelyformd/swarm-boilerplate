#!/bin/sh

export PORTAINER_DOMAIN=portainer
export TRAEFIK_UI_DOMAIN=proxy
export CONSUL_UI_DOMAIN=consul

if [ -f deployments.txt ]; then

    while read p; do

        if [ ! -d $p ]; then
            echo "Removing ${p}"
            echo "--------------"
            docker stack rm "${p}"
        fi

    done < deployments.txt

    rm deployments.txt

fi

for D in *; do

    if [ -d "${D}" ]; then
        echo "Deploying ${D}"
        echo "--------------"
        cd "${D}"
        docker stack deploy -c "./docker-compose.yml" "${D}" --with-registry-auth
        echo ""
        echo ""
        echo "${D}" >> deployments.txt
        cd ../
    fi

done

# Add an empty line at the end of cached deployments.txt
echo "" >> deployments.txt
