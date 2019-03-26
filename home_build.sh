#!/bin/bash

rsp_docker=`docker ps | grep tomcat_new`
if [[ "$rsp_docker" == "" ]]; then
    docker run -name tomcat_new -it -p 8080:8080 tomcat
fi

cd /tmp/

if [[ ! -d tomcat-test ]]; then
    git clone https://github.com/dingyu880623/tomcat-test.git
fi

cd /tmp/tomcat-test/server

mvn clean package

if [[ ! -f server.war ]];then
    echo "maven war failed..."
    exit 1
fi

docker cp server.war tomcat_new:/usr/local/tomcat/webapps
