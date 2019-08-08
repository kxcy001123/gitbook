# webpack 搭建过程中遇到的问题

#### 热更新配置`HMR(Hot Module Replacement)`

1. 在 cli 中使用带--hot 选项的 webpack-dev-server 命令时，不要在 webpack 的配置文件在配置 hot:true。

```javascript
  devServer: {
    hot: true,
    inline: true
  },
```

2. 在不使用第三方 HMR 库，纯搭建自己的本地 node server 时，一定要在项目的入口模块添加 `module.hot.accept` 代码来接受更新消息以实现热更新。

```javascript
import { initThree } from "./example/chapter1/chapter1_1";
initThree();
if (module.hot) {
  module.hot.accept("./example/chapter1/chapter1_1", app => {
    console.log(app);
    initThree();
  });
}
```
