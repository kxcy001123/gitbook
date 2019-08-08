# 第一章

- 总体搭了一个 demo 页面， 普及了下 Scene ,Carmera,Renderer,Light(SpotLight 聚光灯,AmbientLight 环境光),Material(基础材质，对光源响应的材质),Geometry(Plane,Box,Sphere),Mesh(网格)的知识
- 阴影
  - renderer.shadowMap.enabled = true 开启渲染器阴影
  - plane.receiveShadow = true; // 接受阴影
  - cube.castShadow = true; //物品产生阴影
  - spotLight.castShadow = true; // 光源产生阴影
- 动画

  ```javascript
  function renderSenceAnimation() {
    // 立方体
    cube.rotation.x += 0.02;
    cube.rotation.y += 0.02;
    cube.rotation.z += 0.02;
    // 球体
    step += 0.04;
    sphere.position.x = 20 + 10 * Math.cos(step);
    sphere.position.y = 2 + 10 * Math.abs(Math.sin(step));

    statsInstace.update();
    requestAnimationFrame(renderSenceAnimation);
    renderer.render(scene, camera);
  }
  renderSenceAnimation();
  ```

- stats.js

- data.gui.js
 - 只是改变参数，由requestAnimationFrame去不停渲染，而不是类似于React的响应式

- 场景对浏览器的自适应

  ```javascript
  function onResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.resize(window.innerWidth, window.innerHeight);
  }
  ```
