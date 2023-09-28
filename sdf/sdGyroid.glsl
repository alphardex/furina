/*
Define a gyroid fractal SDF function.
Ref: https://www.shadertoy.com/view/wlKSRc
*/

float sdGyroid(vec3 p,float scale,float thickness,float bias){
    p*=scale;
    return abs(dot(sin(p),cos(p.zxy))-bias)/scale-thickness;
}