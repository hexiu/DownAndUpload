# 先编译好服务 然后使用
FROM golang:alpine3.11
RUN apk --no-cache --no-progress add --virtual \
  build-deps \
  build-base \
  git \
  linux-pam-dev
RUN go env -w GOPROXY=https://goproxy.cn,direct
RUN cd / &&wget https://github.com/hexiu/DownAndUpload/archive/refs/heads/main.zip && unzip main.zip && cd DownAndUpload-main && make build && chmod u+x /DownAndUpload-main/server && cp /DownAndUpload-main/upload.html /DownAndUpload-main/upload/
RUN echo -e "*/30\t*\t*\t*\t*\t /bin/sh /DownAndUpload-main/cleanfile.sh" >> /etc/crontabs/root
WORKDIR /DownAndUpload-main/
EXPOSE 8081
CMD ["/DownAndUpload-main/server"]