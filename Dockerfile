FROM node:10.15.3

COPY . /app

WORKDIR /app

RUN npm config set registry https://registry.npm.taobao.org && \
  npm install gitbook-cli -g && \
  gitbook -V && \
  gitbook install
EXPOSE 4000


CMD gitbook serve
