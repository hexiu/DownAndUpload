###
 # @Date: 2021-07-23 11:14:47
 # @LastEditors: jaxiu
 # @LastEditTime: 2021-07-23 11:47:34
 # @FilePath: /test/gin/cleanfile.sh
### 
#!/bin/sh
#
touch client.exe
touch client.mac
touch client.linux
find /DownAndUpload-main/upload -type f -mtime +1 -exec rm -f {} \;