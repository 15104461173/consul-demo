#!/bin/bash
ipaddr=$(ifconfig enp0s3|awk '{if(NR==2){print $2}}')
echo "ip address ${ipaddr}"
echo "start consul server"
docker run -d --name=consul-server --restart=always --net=host consul agent -server -ui -bind=${ipaddr} -bootstrap-expect=1 -client ${ipaddr}' 127.0.0.1'
sleep 5
echo "start fabio"
docker run -d --name=fabio --restart=always --net=host fabiolb/fabio
echo "start registrator"
docker run -d --name=registrator --restart=always --net=host --volume=/var/run/docker.sock:/tmp/docker.sock  gliderlabs/registrator:latest -ip ${ipaddr} consul://localhost:8500