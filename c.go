/*
 * @Date: 2021-07-16 17:43:55
 * @LastEditors: jaxiu
 * @LastEditTime: 2021-07-20 16:58:32
 * @FilePath: /test/gin/c.go
 */
package main

import (
	"bytes"
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"os"
)

var file = flag.String("f", "", "upload filepath+filename")
var domain = flag.String("d", "up.jaxiu.cn", "upload host")

func main() {
	flag.Parse()
	fmt.Println("file:", *file)
	c := http.DefaultClient
	f, err := os.Open(*file)
	if err != nil {
		panic(err)

	}
	defer f.Close()
	body := &bytes.Buffer{}

	w := multipart.NewWriter(body)
	defer w.Close()

	part, err := w.CreateFormFile("file", "s.go")
	if err != nil {
		panic(err)

	}

	io.Copy(part, f)
	ct := w.FormDataContentType()
	w.Close()

	resp, err := c.Post("http://"+*domain+"/up", ct, body)
	if err != nil {
		panic(err)

	}
	fmt.Printf("resp: %+v\n", resp)
	b, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		panic(err)

	}
	fmt.Printf("resp body: %+v\n", string(b))

	defer resp.Body.Close()
}
