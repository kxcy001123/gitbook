# 接口请求下载数据流文件

#### 基于`axios`请求数据流文件

1. 除了公共的`axios`设置的请求头之外，还需要一些别的设置项

   ```javascript
   options.header = {
     ...header,
     "Content-Type": "application/octet-stream;charset=UTF-8"
   };
   options.responseType = "arraybuffer";
   ```

2. 数据返回之后对数据做处理

   ```javascript
   if (
     res.headers["content-type"] === "application/octet-stream;charset=UTF-8"
   ) {
     const filename = res.headers["content-disposition"].split("=")[1];
     let url = window.URL.createObjectURL(
       new Blob([res.data], { type: "application/vnd.ms-excel" });
     );
     let link = document.createElement("a");
     link.style.display = "none";
     link.href = url;
     link.setAttribute("download", filename);

     document.body.appendChild(link);
     link.click();
     return Promise.resolve({
       success: true
     });
   }
   ```

3. 数据返回之后对数据做处理(优化)

- 正常情况下，后端会返回 buffer 文件流，上面的处理方法可以正常工作
- 有时系统异常，这时后端会返回 JSON，例如`{"msg":"系统异常","code":1,"success":false}`,也被转成了 arraybuffer,所以需要特殊处理下

```javascript
if (res.config.responseType === "arraybuffer") {
  if (
    res.headers["content-type"] === "application/octet-stream;charset=UTF-8"
  ) {
    let filename = "文件";
    try {
      filename = res.headers["content-disposition"].split("=")[1];
    } catch (error) {}
    let url = window.URL.createObjectURL(
      new Blob([res.data], { type: "application/vnd.ms-excel" })
    );
    let link = document.createElement("a");
    link.style.display = "none";
    link.href = url;
    link.setAttribute("download", filename);

    document.body.appendChild(link);
    link.click();
    return Promise.resolve({
      success: true
    });
  } else {
    let enc = new TextDecoder("utf-8");
    let data = JSON.parse(enc.decode(new Uint8Array(res.data))); //转化成json对象
    return Promise.resolve({
      success: false,
      data
    });
  }
}
```
