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
