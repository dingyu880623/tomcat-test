#!/bin/bash

rsp_docker=`docker ps | grep tomcat_new`
if [[ "$rsp_docker" == "" ]]; then
    docker run -name tomcat_new -it -p 8080:8080 tomcat
fi

cd /tmp/

if [[ ! -d HelloWorld ]]; then
#    修改地址
    git clone https://github.com/siggy86/HelloWorld.git
fi

cd /tmp/HelloWorld

mvn clean

mvn compile

cd /tmp/HelloWorld/

jar -cvf test.war ./*

docker cp test.war   tomcat_new:/xxxxxx



