.PHONY: all build run gotool clean help

BINARYS="server"
BINARYC="client"


all: clean gotool build

builds:
	@if [ ! -d "upload" ] ; then mkdir "upload" ; fi
	CGO_ENABLED=0 GOOS=`go env GOOS` GOARCH=amd64 go build -o ${BINARYS} ./s.go

buildc: buildcw buildcm buildcl


buildcw: 
	@if [ ! -d "upload" ] ; then mkdir "upload" ; fi
	CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build -o ${BINARYC}.exe ./c.go

buildcl: 
	@if [ ! -d "upload" ] ; then mkdir "upload" ; fi
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ${BINARYC}.linux ./c.go

buildcm: 
	@if [ ! -d "upload" ] ; then mkdir "upload" ; fi
	CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o ${BINARYC}.mac ./c.go

build: buildc builds mvworkdir

mvworkdir:
	mv client.exe   client.linux client.mac ./upload

run:
	@if [ ! -d "upload" ] ; then mkdir "upload" ; fi
	@go run ./s.go

gotool:
	go fmt ./
	go vet ./c.go
	go vet ./s.go

clean:
	@if [ -f ${BINARYS} ] ; then rm ${BINARYS} ; fi
	@if [ -f ${BINARYC}.exe ] ; then rm ${BINARYC}.exe  ; fi
	@if [ -f ${BINARYC}.mac ] ; then rm ${BINARYC}.mac ; fi
	@if [ -f ${BINARYC}.linux ] ; then rm ${BINARYC}.linux ; fi
	@if [ -d "upload" ] ; then rm -r "upload" ; fi
	

help:
	@echo "make - 格式化 Go 代码, 并编译生成二进制文件"
	@echo "make build - 编译 Go 代码, 生成二进制文件"
	@echo "make run - 直接运行 Go 代码"
	@echo "make clean - 移除二进制文件和 vim swap files"
	@echo "make gotool - 运行 Go 工具 'fmt' and 'vet'"
