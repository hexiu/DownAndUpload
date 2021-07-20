# 先编译好服务 然后使用
FROM golang:alpine3.11
RUN cd / &&wget https://github.com/hexiu/DownAndUpload/archive/refs/heads/main.zip && unzip main.zip && cd DownAndUpload-main && make build && chmod u+x /DownAndUpload-main/server 
WORKDIR /DownAndUpload-main/
EXPOSE 8081
CMD ["/DownAndUpload-main/server"]