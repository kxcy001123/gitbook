# Nginx 命令

#### 启动

> cd usr/local/nginx/sbin

> ./nginx

#### 重启

> cd /usr/local/nginx/sbin

> ./nginx -s reload

#### 判断配置文件是否正确

> ./nginx -t -c /usr/local/nginx/conf/nginx.conf

> ./nginx -t

#### 关闭

- 查询 nginx 主进程号

  > ps -ef | grep nginx

  - 从容停止 kill -QUIT 主进程号
  - 快速停止 kill -TERM 主进程号
  - 强制停止 kill -9 nginx

## 将 nginx 配置成自启动的服务

- 添加至服务管理列表，并让其开机自动启动

```
  [root@nginx ~]# chkconfig --add nginx
  [root@nginx ~]# chkconfig nginx on
  [root@nginx ~]# chkconfig nginx --list
  nginx              0:关闭    1:关闭    2:启用    3:启用    4:启用    5:启用    6:关闭
```

- nginx 启动、停止、无间断服务重启

```
  [root@example ~]# service nginx start

  [root@example ~]# service nginx stop

  [root@example ~]# service nginx reload

```

- 查看一下端口

```

  [root@nginx ~]# netstat -ntlp | grep :80
  tcp        0      0 0.0.0.0:80                  0.0.0.0:*                   LISTEN      3889/nginx

```
