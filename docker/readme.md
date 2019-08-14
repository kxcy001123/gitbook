# Docker 入门

#### 公司内使用 Docker 部署，简单学习了下，记录下学习记录

1. 容器和 VM（虚拟机）的主要区别是

   - 容器提供了基于进程的隔离，而虚拟机提供了资源的完全隔离。
   - 虚拟机可能需要一分钟来启动，而容器只需要一秒钟或更短。
   - 容器使用宿主操作系统的内核，而虚拟机使用独立的内核。

2. 阿里云安装 dokcer

   - 我的阿里云是 CentOS 的，官方也有安装教程
   - 安装过程

     ```Shell
       yum install docker -y // 安装
       docker -v // 版本检查
       service docker start  // 启动docker
       chkconfig docker on   // 设置开机自启动

     ```

   - 常用命令

     ```
       docker image pull   // 拉取docker Image
       docker image build
       docker image ls     // 查看本地Image 列表
       docker image rm
       docker container run -p -v -it   // docker 容器启动
       docker container ls
       docker cp
     ```

3. 尝试将这个 gitbook 用 docker 部署到我的阿里云上

   - 新建 Dockerfile 文件

   ```dockerfile
      // 继承node镜像
     FROM node:10.15.3
     COPY . /app
     WORKDIR /app
     RUN npm config set registry https://registry.npm.taobao.org && \
      npm install gitbook-cli -g && \
      gitbook -V && \
      gitbook install
     EXPOSE 4000

   ```

   - push 到 github 上
   - 阿里云拉取代码

   - build image 默认使用 Dockerfile 文件， 可用 -f xx 指定文件

     ```
       docker image build -t gitbook:0.0.1 (-f xx) .
     ```

   - 启动 container

     ```
       docker container run -p 3301:4000 -it gitbook:0.0.1
     ```

   - ctrl+c 退出 node，

   - 查看 docker 容器
     ```
      docker container ls -all
     ```
   - 通过 start 命令启动 container

   ```
     docker container start id
   ```

- 搞定～
