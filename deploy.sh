#!/bin/sh

echo -e  "\n\n1. Applying configuration from env.sh\n"

if [ -f env.sh ]; then
    ./env.sh
else
    echo "--> No configuration found"
fi

echo -e  "\n\n2. Creating global networks\n"

NETWORKS=$(docker network ls)

echo -e  "Creating proxy network"
if [ grep "proxy\s*overlay" <<< "$NETWORKS" ]; then
    echo -e  "--> proxy network already exists"
else
    docker network create -d overlay proxy
fi

echo -e  "Creating database network"
if [ grep "database\s*overlay" <<< "$NETWORKS" ]; then
    echo -e  "--> database network already exists"
else
    docker network create -d overlay database
fi

echo -e  "\n\n3. Stopping removed stacks\n"

if [ -f deployments.txt ]; then

    while read p; do

        if [ ! -d $p ]; then
            echo -e  "--> Removing ${p}"
            docker stack rm "${p}"
        fi

    done < deployments.txt

    rm deployments.txt

fi

echo -e  "\n\n4. Deploying current stacks\n"

for D in *; do

    if [ -d "${D}" ]; then
        echo -e  "--> Deploying ${D}"
        # docker stack deploy -c "./${D}/docker-compose.yml" "${D}" --with-registry-auth
        echo -e  "\n"
        echo -e  "${D}" >> deployments.txt
    fi

done

# Add an empty line at the end of cached deployments.txt
echo "" >> deployments.txt
