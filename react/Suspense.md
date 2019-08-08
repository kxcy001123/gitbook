# React Suspense

#### 在`Antdpro`看到对 React.Suspense 的使用

#### 简单介绍一下 Suspense

- 在 render 函数中，我们可以写入一个异步请求，请求数据 react 会从我们缓存中读取这个缓存如果有缓存了，直接进行正常的 render 如果没有缓存，那么会抛出一个异常，这个异常是一个 promise 当这个 promise 完成后（请求数据完成），react 会继续回到原来的 render 中（实际上是重新执行一遍 render），把数据 render 出来完全同步写法，没有任何异步 callback 之类的东西
- 如果你还没有明白这是什么意思那我简单的表述成下面这句话：

  ```
    调用render函数->发现有异步请求->悬停，等待异步请求结果->再渲染展示数据

  ```

---

#### 用现在的 React 16+实现 Suspense

- 这个 suspense 很神奇，但是当你知道了具体细节了以后，你就觉得，噢～～～～～～原来是这样，那么根据之前我们的介绍，全文的最关键的一个地方就是：如果没有缓存，那么会抛出一个异常，这个异常是一个 promise

- 我们知道，无论是什么异常，JavaScript 都能捕获，React 就是利用了这个语言特性，捕获了所有生命周期函数，render 函数，以及事件回调中的任何错误，封装进一个特殊的生命周期里：ComponentDidCatch

- 那么实际上，Suspense 就是依赖 ComponentDidCatch 实现的。

```javascript
import React from "react";

var cached = {};
export const createFetcher = promiseTask => {
  let ref = cached;
  return () => {
    const task = promiseTask();
    task.then(res => {
      ref = res;
    });
    if (ref === cached) {
      throw task;
    }
    return ref;
  };
};

export class Base extends React.Component {
  state = {
    error: false
  };

  componentDidCatch(error) {
    if (this._mounted) {
      if (typeof error.then === "function") {
        this.setState({ error: true });
        error.then(() => {
          if (this._mounted) {
            this.setState({ error: false });
          }
        });
      }
    }
  }
  componentDidMount() {
    this._mounted = true;
  }
  componentWillUnmount() {
    console.log("unm");
    this._mounted = false;
  }
}

export class Placeholder extends Base {
  render() {
    const { children } = this.props;
    const { error } = this.state;

    return error ? "加载数据中，请稍后..." : children;
  }
}

export class Loading extends Base {
  render() {
    const { children } = this.props;
    const { error } = this.state;

    return children(error);
  }
}
```

---

#### 思考

- 这一种组件的书写方式，可以说完全破坏了我们之前的固有思维：render 必须是纯函数
- 好处：非常实用，这一部分啰啰嗦嗦的逻辑在 redux 中搞的话，必须得指定多个状态然后才能完事在 Jsx 层解决这种常见的副作用，在同构应用中发挥更大的效果，因为代码可以更统一，我个人认为这是一个非常优雅的方式异步同步化。异步的同步化这几年一直都在做，而且这一次可以说解决得更加彻底，连之前的 yield async/await 都没了副作用粒度小，本来一个组件的「自更新」就是他自己的事情，得益于这样的设计，我们的组件可以重新回归，自己状态自己管理这种好事中去。
- 坏处 Hack，不得不说，虽然巧妙，但是用 throw promise 是一个 hack，利用语言特性制造的这种 hack，可能会导致某些问题难以排查。我想这也就是为什么 react team 把一个「本来可以放在外面实现的功能，写进了 react」，他们一定也在摸索到底会有什么奇怪的 bug。render 函数不再纯：一个纯函数的最大好处就是，他的一切结果我们都能预知，带有副作用的函数一两个还好，多了就可能会导致 bug。况且，render 函数并不是一个普通的函数，而是 React 的根基，每一个组件都必须要有一个 render（无状态组件也叫 render） 函数。
