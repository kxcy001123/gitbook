# 第二章

#### Scene 相关 API

- add
- remove
- children
- getObjectByName('cube-17') cube.name = 'cube-17'
- traverse(fun) 递归遍历 scene 子对象
- fog 雾化

  ```javascript
  scene.fog = new THREE.Fog(0xffffff, near, far); //雾的浓度线性增长
  ```

  ```javascript
  scene.fog = new THREE.FogExp2(0xffffff, 0.01); // 0.01 浓度  指数增长
  ```

- overrideMaterial // 强制所有物体(包括后续添加到 Scene 中的)使用该材质

- SceneUtils.createMultiMaterialObject() // 新版本工具函数从 three 中移除了，需要单独引入

  ```javascript
  import { SceneUtils } from "three/examples/jsm/utils/SceneUtils";
  ```

#### 几何体与网络

> 创建一个网格需要一个几何体，以及一个或多个材质， 创建好之后可以将其加入场景

- 点 3 维坐标系 (x,y,z) `new THREE.Vector3(1,3,1)`
- 面 三点一面 `new THREE.Faces(0,1,2)`

```javascript
//  点
var vertices = [
  new THREE.Vector3(1, 3, 1),
  new THREE.Vector3(1, 3, 2),
  new THREE.Vector3(1, 3, 3),
  new THREE.Vector3(2, 1, 4),

];
// 面   顺时针 面对    逆时针  背对
var faces = [new THREE.Face3(0, 2, 1)，new THREE.Face3(4, 1, 2)，new THREE.Face3(2, 1, 4)];  //顶点顺序决定面是否背对摄像机
// 几何体
var gemo = new THREE.Geometry();
gemo.vertives = vertices;
gemo.faces = faces;
gemo.computeFaceNormals(); // 决定面的法向量，法向量用于觉得不同光源下的颜色 ？？
// 材质
let planeMaterail = new THREE.MeshBasicMaterial({ color: 0xff0000 });
// 网格
let plane = new THREE.Mesh(gemo, planeMaterail);
scene.add(plane);
```

- 网格对象的属性和方法

  - position 相对于父对象
    - position.x .y .z position.set(x,y,z) position = new THREE.Vector3(x,y,z)
  - rotation
    - rotateX,rotateY,rotateZ
  - scale readonly
    - cube.scale.set(x,y,z)
  - translateX translateY translateZ
  - visiable

- camera
  - PerspectiveCamera() 透视投影摄像机 近大远小
  - OrthographicCamera() 正交投影摄像机 与距离无关
