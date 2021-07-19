/*
 * @Date: 2021-07-16 17:20:08
 * @LastEditors: jaxiu
 * @LastEditTime: 2021-07-19 18:50:21
 * @FilePath: /test/gin/s.go
 */
package main

import (
	"fmt"
	"net/http"
	"path"

	"github.com/gin-gonic/gin"
)

type RunStatus struct {
	Status string // 运行状态
	Usage  string // 使用说明
}

var Domain = "http://0.0.0.0:8081"

func main() {

	r := gin.Default()

	r.GET("/", func(c *gin.Context) {
		c.JSON(200, &RunStatus{
			Status: "服务运行中",
			Usage:  "下载客户端： \nwin客户端 http://" + Domain + "/download/client.exe\nLinux客户端 http://" + Domain + "/download/client.linux\nMac客户端 http://" + Domain + "/download/client.mac\n客户端的使用方式：./client* -h ",
		})
	})
	r.Static("/download", "./upload")
	r.POST("/up", s)

	r.Run("0.0.0.0:8081")
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
		"downurl": "http://0.0.0.0:8081/download/" + f.Filename,
	})
}
