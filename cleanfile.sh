###
 # @Date: 2021-07-23 11:14:47
 # @LastEditors: jaxiu
 # @LastEditTime: 2021-07-23 11:35:06
 # @FilePath: /test/gin/cleanfile.sh
### 
#!/bin/sh
#
find /DownAndUpload-main/upload -type f -mtime +1 -exec rm -f {} \;