#!/bin/bash
ipaddr=$(ifconfig enp0s3|awk '{if(NR==2){print $2}}')
echo "ip address ${ipaddr}"
echo "start consul server"
    #with another node to join
echo "try join $1"
docker stop consul-client
docker rm consul-client
docker run -d --name=consul-client --restart=always --net=host consul agent -ui -bind=${ipaddr} -retry-join=$1 -client ${ipaddr}' 127.0.0.1'
sleep 5
echo "start fabio"
docker stop fabio
docker rm fabio
docker run -d --name=fabio --restart=always --net=host fabiolb/fabio
echo "start registrator"
docker stop registrator
docker rm registrator
docker run -d --name=registrator --restart=always --net=host --volume=/var/run/docker.sock:/tmp/docker.sock  gliderlabs/registrator:latest -ip ${ipaddr} consul://localhost:8500