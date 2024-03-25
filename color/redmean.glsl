/*
A method to calculate color distance.
Ref: https://en.wikipedia.org/wiki/Color_difference
*/

float redmean(vec3 c1,vec3 c2){
    float rm=(c1.x+c2.x)*.5*256.;
    vec3 d=(c1-c2)*256.;
    
    float r=(2.+rm/256.)*d.x*d.x;
    float g=4.*d.y*d.y;
    float b=(2.+(255.-rm)/256.)*d.z*d.z;
    return sqrt(r+g+b)/256.;
}