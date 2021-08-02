###
 # @Date: 2021-07-23 11:14:47
 # @LastEditors: jaxiu
 # @LastEditTime: 2021-08-02 10:35:25
 # @FilePath: /test/gin/cleanfile.sh
### 
#!/bin/sh
#
touch client.exe
touch client.mac
touch client.linux
touch upload.html
find /DownAndUpload-main/upload -type f -mtime +1 -exec rm -f {} \;