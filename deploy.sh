#!/bin/sh

echo "\n\n1. Applying configuration from env.sh"

if [ -f env.sh ]; then
    ./env.sh
fi

echo "\n\n2. Creating global networks"

NETWORKS=$(docker network ls)

if [ grep -q 'proxy' <<< $NETWORKS ]; then
    docker network create -d overlay proxy
fi

if [ grep -q 'database' <<< $NETWORKS ]; then
    docker network create -d overlay database
fi

echo "\n\n3. Stopping removed stacks"

if [ -f deployments.txt ]; then

    while read p; do

        if [ ! -d $p ]; then
            echo "--> Removing ${p}"
            docker stack rm "${p}"
        fi

    done < deployments.txt

    rm deployments.txt

fi

echo "\n\n4. Deploying current stacks"

for D in *; do

    if [ -d "${D}" ]; then
        echo "--> Deploying ${D}"
        docker stack deploy -c "./${D}/docker-compose.yml" "${D}" --with-registry-auth
        echo "\n"
        echo "${D}" >> deployments.txt
    fi

done

# Add an empty line at the end of cached deployments.txt
echo "" >> deployments.txt
