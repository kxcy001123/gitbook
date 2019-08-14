# 部署 gitbook2

1,2 同上

3. 创建`Dockerfile`

   ```
     FROM gitbook:0.0.1
     EXPOSE 4000
     CMD cd gitbook && gitbook serve

   ```

todo 考虑把 nginx 转发放进去 `docker` 中
