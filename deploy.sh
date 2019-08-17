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
-e SERVICE_8080_CHECK_HTTP=/health \
-e SERVICE_8080_NAME=${container_name} \
-e SERVICE_CHECK_INTERVAL=10s \
-e SERVICE_CHECK_TIMEOUT=5s \
-e SERVICE_TAGS=urlprefix-/hostnameserver \
${docker_image} \
java \
-server \
-jar \
/app.jar