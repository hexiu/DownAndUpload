.PHONY: all build run gotool clean help

BINARYS="server"
BINARYC="client"


all: gotool build

builds:
	CGO_ENABLED=0 GOOS=`go env GOOS` GOARCH=amd64 go build -o ${BINARYS} ./s.go

buildc:
	CGO_ENABLED=0 GOOS=`go env GOOS` GOARCH=amd64 go build -o ${BINARYC} ./c.go

build: buildc builds


run:
	@go run ./s.go

gotool:
	go fmt ./
	go vet ./

clean:
	@if [ -f ${BINARYS} ] ; then rm ${BINARYS} ; fi
	@if [ -f ${BINARYC} ] ; then rm ${BINARYC} ; fi

help:
	@echo "make - 格式化 Go 代码, 并编译生成二进制文件"
	@echo "make build - 编译 Go 代码, 生成二进制文件"
	@echo "make run - 直接运行 Go 代码"
	@echo "make clean - 移除二进制文件和 vim swap files"
	@echo "make gotool - 运行 Go 工具 'fmt' and 'vet'"
