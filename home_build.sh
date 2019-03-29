#!/bin/bash

rsp_docker=`docker ps | grep tomcat_new`
if [[ "$rsp_docker" == "" ]]; then
    docker run --name tomcat_new -d -p 8080:8080 tomcat
fi

#if [[ ! -d /tmp/tomcat-test ]]; then
#    git clone https://github.com/dingyu880623/tomcat-test.git
#fi

cd "$(dirname "$0")"

cd server

mvn clean package

if [[ ! -f target/HelloWorld.war ]];then
    echo "maven war failed..."
    exit 1
fi

docker cp target/HelloWorld.war tomcat_new:/usr/local/tomcat/webapps
