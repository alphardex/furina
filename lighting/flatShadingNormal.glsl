/*
Implement flat shading in fragment Shader.
Ref: https://gamedev.stackexchange.com/a/154857
*/

vec3 flatShadingNormal(vec3 normal){
    vec3 xTangent=dFdx(normal);
    vec3 yTangent=dFdy(normal);
    vec3 fNormal=normalize(cross(xTangent,yTangent));
    return fNormal;
}