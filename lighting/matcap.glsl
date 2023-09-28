/*
Implement matcap lighting technique.
Ref: https://ycw.github.io/three-shaderlib-skim/dist/#/latest/matcap/fragment
*/

vec2 matcap(vec3 viewPosition,vec3 normal){
    vec3 viewDir=normalize(viewPosition);
    vec3 x=normalize(vec3(viewDir.z,0.,-viewDir.x));
    vec3 y=cross(viewDir,x);
    vec2 uv=vec2(dot(x,normal),dot(y,normal))*.495+.5;
    return uv;
}