###
 # @Date: 2021-08-02 10:40:38
 # @LastEditors: jaxiu
 # @LastEditTime: 2021-08-02 10:49:39
 # @FilePath: /test/gin/build.sh
### 
#!/bin/bash 
#
# 暂停以前的服务
git pull 

docker ps | grep dau 
[ $? -eq 0 ] && docker stop dau && docker rm dau

docker images | grep downandupload 
[ $? -eq 0 ] && docker rmi downandupload:v0.0.1

docker build -t downandupload:v0.0.1 .
docker run  -dti --name dau -p 8081:8081 downandupload:v0.0.1

docker ps | grep dau 
[ $? -eq 0 ] && echo "dau running ..."


