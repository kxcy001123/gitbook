# 第三章/光源

- AmbientLight 环境光
- PointLIght 点光源
- SpointLight 聚光灯光源
  - helper   
  - 一些属性值新版本发生变化
  ```javascript
  var helper = new THREE.CameraHelper(spotLight.shadow.camera);
  spotLight.shadow.camera.near = 2;
  spotLight.shadow.camera.far = 200;
  spotLight.shadow.camera.fov = 30;
  ```
- DirectionalLight 平行光
- HemisphereLight
- AreaLight