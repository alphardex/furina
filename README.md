<div align="center">
  <img src="./assets/logo.jpg" width="200">
  <h1>furina</h1>
  <p>A Shader util functions library.</p>
</div>
<p>
  <img alt="Version" src="https://img.shields.io/npm/v/furina.svg?v=1" />
  <a href="#" target="_blank">
    <img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-yellow.svg" />
  </a>
  <a href="https://twitter.com/alphardex007" target="_blank">
    <img alt="Twitter: alphardex007" src="https://img.shields.io/twitter/follow/alphardex007.svg?style=social" />
  </a>
</p>

> Furina, the God of Justice "Focalors" in Fontaine.

## Install

```sh
npm i furina
```

## How to use it?

If you're using vite, you may need to install a plugin——[vite-plugin-glsl](https://github.com/UstymUkhman/vite-plugin-glsl):

```sh
npm i -D vite-plugin-glsl
```

Config the plugin in `vite.config.js`:

```js
import { defineConfig } from "vite";

import glsl from "vite-plugin-glsl";

export default defineConfig({
  plugins: [glsl()],
});
```

In your Shader, just `#include` the functions you need:

```glsl
#include "/node_modules/furina/image/cover.glsl"

uniform float iTime;
uniform vec3 iResolution;
uniform vec4 iMouse;

uniform sampler2D uTexture;

varying vec2 vUv;

uniform vec2 uMediaSize;
uniform float uOpacity;

void main(){
    vec2 uv=vUv;
    uv=cover(iResolution.xy,uMediaSize.xy,uv);
    vec4 tex=texture(uTexture,uv);
    vec3 color=tex.rgb;
    gl_FragColor=vec4(color,uOpacity);
}
```

## Author

👤 **alphardex**

- Twitter: [@alphardex007](https://twitter.com/alphardex007)
- Github: [@alphardex](https://github.com/alphardex)

## Show your support

Give a ⭐️ if this project helped you!

---

_This README was generated with ❤️ by [readme-md-generator](https://github.com/kefranabg/readme-md-generator)_
