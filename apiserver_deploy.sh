#!/bin/bash
docker_image=$1
container_name='hostname-server'
echo "remove docker container:"${container_name}
docker stop ${container_name}
docker rm ${container_name}
echo "remove docker image:"${docker_image}
docker rmi ${docker_image}
echo "run docker container"
docker run -d \
--name=${container_name} \
--restart=always \
--net=host \
-p 8080:8080 \
-e SERVICE_NAME=${container_name} \
-e SERVICE_CHECK_HTTP=/healthy \
-e SERVICE_CHECK_INTERVAL=5s \
-e SERVICE_CHECK_TIMEOUT=2s \
-e SERVICE_TAGS="urlprefix-/${container_name} strip=/${container_name}" \
${docker_image} \
java -jar app.jar