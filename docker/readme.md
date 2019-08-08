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
       docker image ls     // 查看本地Image 列表
       docker container run   // docker 容器启动
     ```
