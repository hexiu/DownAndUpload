# 一个尽可能简单的便捷好用的文件中转站
### 服务端 


### 客户端


### 运行方式
#### dockerfile  
`sudo docker build -t downandupload:v0.0.1 .`

### 使用手册
1. 下载客户端： 
   1. linux 客户端： `wget http://up.jaxiu.cn/download/client.linux`
   2. mac 客户端： `wget http://up.jaxiu.cn/download/client.mac` 
   3. windows 客户端： `wget http://up.jaxiu.cn/download/client.exe`

2. 终端使用：  `./client -f /your/filepath ` [如果你是自建，`./client -f /your/filepath -d "your hosts"`]
3. 其他地方文件下载，看上传返回信息。