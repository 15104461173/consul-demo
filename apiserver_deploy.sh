#!/bin/bash
container_name='hostname-server'
docker_image='15104461173/consul-demo'
echo "remove docker container"
docker stop ${container_name}
docker rm ${container_name}
echo "pull docker image"
docker pull ${docker_image}
echo "run docker container"
docker run -d --name=${container_name} --restart=always --net=host -p 8080:8080 \
-e SERVICE_NAME=${container_name} \
-e SERVICE_CHECK_HTTP=/healthy \
-e SERVICE_CHECK_INTERVAL=5s \
-e SERVICE_CHECK_TIMEOUT=2s \
-e SERVICE_TAGS="urlprefix-/${container_name} strip=/${container_name}" \
${docker_image} \
java -jar app.jar