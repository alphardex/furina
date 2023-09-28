/*
Simulate CSS's "background: cover" in Shader.
Ref: https://gist.github.com/statico/df64c5d167362ecf7b34fca0b1459a44
*/

vec2 cover(vec2 s,vec2 i,vec2 uv){
    float rs=s.x/s.y;
    float ri=i.x/i.y;
    vec2 new=rs<ri?vec2(i.x*s.y/i.y,s.y):vec2(s.x,i.y*s.x/i.x);
    vec2 offset=(rs<ri?vec2((new.x-s.x)/2.,0.):vec2(0.,(new.y-s.y)/2.))/new;
    uv=uv*s/new+offset;
    return uv;
}