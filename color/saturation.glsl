/*
Saturate a color.
*/

vec3 saturation(vec3 rgb,float adjustment){
    float intensity=dot(rgb,vec3(.2126,.7152,.0722));
    return mix(vec3(intensity),rgb,adjustment);
}