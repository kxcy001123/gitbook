# React hooks

#### useState useEffect

- 每次更新都会执行 App
- 惰性初始 state: useState(initialState 参数只会在组件的初始渲染中起作用，后续渲染时会被忽略)
- 每次更新会先执行 useEffect 返回的 `清除函数`

```javascript
function useDocumentTitle(title) {
  useEffect(() => {
    console.log("useDocumentTitle");
    document.title = title;
    return () => {
      console.log("return useDocumentTitle effect");
      document.title = "demo";
    };
  }, [title]);
}

function App() {
  let [count, setCount] = useState(0);
  console.log("app");
  document.title = "dasda";
  useEffect(() => {
    console.log("effect");

    if (count >= 10) {
      setCount(0);
    }
    return () => {
      console.log("return appUseEffect effect");

      console.log(count);
    };
  }, [count]);
  useDocumentTitle("个人中心");
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <Counter init={2} />
        <ChatRecipientPicker />
        <p>点击{count}次</p>
        <button
          onClick={() => {
            setCount(count + 1);
          }}
        >
          点击
        </button>
      </header>
    </div>
  );
}
```

#### useReducer

- 在某些场景下，useReducer 会比 useState 更适用，例如 state 逻辑较复杂且包含多个子值，或者下一个 state 依赖于之前的 state 等
- 使用 useReducer 还能给那些会触发深更新的组件做性能优化，因为你可以向子组件传递 dispatch 而不是回调函数
- React 会确保 dispatch 函数的标识是稳定的，并且不会在组件重新渲染时改变。这就是为什么可以安全地从 useEffect 或 useCallback 的依赖列表中省略 dispatch
- 惰性初始化 需要将 init 函数作为 useReducer 的第三个参数传入，这样初始 state 将被设置为 init(initialArg)

```javascript
const initialState = { count: 0 };

function reducer(state, action) {
  switch (action.type) {
    case "increment":
      return { count: state.count + 1 };
    case "decrement":
      return { count: state.count - 1 };
    default:
      throw new Error();
  }
}

function Counter({ initialState }) {
  const [state, dispatch] = useReducer(reducer, initialState, init);
  return (
    <>
      Count: {state.count}
      <button onClick={() => dispatch({ type: "increment" })}>+</button>
      <button onClick={() => dispatch({ type: "decrement" })}>-</button>
    </>
  );
}
```
