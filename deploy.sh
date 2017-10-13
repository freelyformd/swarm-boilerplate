#!/bin/sh


echo "\n\n1. Applying configuration from env.sh\n"

if [ -f env.sh ]; then
    ./env.sh
else
    echo "--> No configuration found"
fi


echo "\n\n2. Creating global networks\n"

NETWORKS=$(docker network ls)

echo "Creating proxy network"
if docker network ls | grep -q "proxy\s*overlay"; then
    echo  "--> proxy network already exists"
else
    docker network create -d overlay proxy
fi

echo "Creating database network"
if docker network ls | grep -q "database\s*overlay"; then
    echo "--> database network already exists"
else
    docker network create -d overlay database
fi

echo "\n\n3. Stopping removed stacks\n"

if [ -f deployments.txt ]; then

    while read p; do

        if [ ! -d $p ]; then
            echo "--> Removing ${p}"
            docker stack rm "${p}"
        fi

    done < deployments.txt

    rm deployments.txt

fi

echo "\n\n4. Deploying current stacks\n"

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
