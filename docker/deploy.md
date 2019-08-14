# 部署 gitbook

#### 上面的 docker 部署很弱智，每次提交代码，docker 镜像都需要 build 一次，容器也需要重新 run

#### 改进 （这种也不好，要把 github 公钥放进 docker 中，）

1. 创建 `Dockerfile_v2`, gitbook 基础镜像

   ```
     FROM node:10.15.3

     RUN npm config set registry https://registry.npm.taobao.org && \
       npm install gitbook-cli -g && \
       gitbook -V && \
       gitbook install

     CMD /bin/echo gitbook-cli gitbook 初始化完成

   ```

2. 将 gitbook 基础镜像推送的 docker 服务器上`hub.docker.com`，

   ```
     docker login
     docker image tag [imageName] [username]/[repository]:[tag]
     docker image push [username]/[repository]:[tag]

   ```

3. 创建`Dockerfile`

   ```
     FROM gitbookinit:0.0.1
     EXPOSE 4000
     CMD git clone git@github.com:kxcy001123/gitbook.git && cd gitbook && gitbook serve

   ```
