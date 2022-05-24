/*
 * @Date: 2021-07-16 17:20:08
 * @LastEditors: jaxiu
 * @LastEditTime: 2021-08-11 10:31:53
 * @FilePath: /test/gin/s.go
 */
package main

import (
	"flag"
	"fmt"
	"net/http"
	"path"

	"github.com/gin-gonic/gin"
)

var Domain = flag.String("d",
	"up.jaxiu.cn",
	"-d your service domain.",
)

var Host = flag.String(
	"h",
	"0.0.0.0:8081",
	"-h your hosts ip and port",
)

func main() {

	flag.Parse()
	r := gin.Default()
	fmt.Println(gin.Version)

	r.GET("/", func(c *gin.Context) {
		c.JSON(http.StatusOK, gin.H{
			"Status": "服务运行中",
			"Usage":  "下载客户端： \nwin客户端 http://" + *Domain + "/download/client.exe\nLinux客户端 http://" + *Domain + "/download/client.linux\nMac客户端 http://" + *Domain + "/download/client.mac\n客户端的使用方式：./client* -h ",
		})
	})
	r.Static("/download", "./upload")
	r.POST("/up", s)

	r.Run(*Host)
	return
}

func s(c *gin.Context) {
	fmt.Printf("Req: %+v\n", c.Request)
	f, err := c.FormFile("file")
	if err != nil {
		fmt.Println("啥也不是", err)
		c.JSON(502, err)
		return
	}
	//将文件保存至本项目根目录中
	c.SaveUploadedFile(f, path.Join("upload", f.Filename))
	//保存成功返回正确的Json数据
	c.JSON(http.StatusOK, gin.H{
		"message": "OK",
		"downurl": "http://" + *Domain + "/download/" + f.Filename,
	})
}
