/*
Saturate a color.
*/

float rgb2luma(const in vec3 rgb){return dot(rgb,vec3(.2126,.7152,.0722));}
float rgb2luma(const in vec4 rgb){return rgb2luma(rgb.rgb);}

float luma(float v){return v;}
float luma(in vec3 v){return rgb2luma(v);}
float luma(in vec4 v){return rgb2luma(v.rgb);}

vec3 saturation(vec3 rgb,float adjustment){
    float intensity=luma(rgb);
    return mix(vec3(intensity),rgb,adjustment);
}