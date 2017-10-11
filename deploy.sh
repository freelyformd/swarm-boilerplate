#!/bin/sh

if [ -f env.sh ]; then
    echo "1. Applying config from env.sh"
    source ./env.sh
fi

if [ -f deployments.txt ]; then

    echo "2. Stopping removed stacks"

    while read p; do

        if [ ! -d $p ]; then
            echo "--> Removing ${p}"
            docker stack rm "${p}"
        fi

    done < deployments.txt

    rm deployments.txt

fi

echo "3. Deploying current stacks"

for D in *; do

    if [ -d "${D}" ]; then
        echo "--> Deploying ${D}"
        docker stack deploy -c "./${D}/docker-compose.yml" "${D}" --with-registry-auth
        echo ""
        echo ""
        echo "${D}" >> deployments.txt
    fi

done

# Add an empty line at the end of cached deployments.txt
echo "" >> deployments.txt
