/*
A function to get the spherical coordinates of a point.
Ref: https://github.com/mrdoob/three.js/blob/master/src/math/Spherical.js
*/

vec3 spherical(float r,float theta,float phi){
    float x=r*sin(phi)*cos(theta);
    float y=r*cos(phi);
    float z=r*sin(phi)*sin(theta);
    vec3 s=vec3(x,y,z);
    return s;
}