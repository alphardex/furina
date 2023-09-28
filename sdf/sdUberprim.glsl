/*
Define a uberprim SDF function.
Ref: https://www.shadertoy.com/view/MsVGWG
*/

float sdUnterprim(vec3 p,vec4 s,vec3 r,vec2 ba,float sz2){
    vec3 d=abs(p)-s.xyz;
    float q=length(max(d.xy,0.))+min(0.,max(d.x,d.y))-r.x;
    // hole support
    q=abs(q)-s.w;
    
    vec2 pa=vec2(q,p.z-s.z);
    vec2 diag=pa-vec2(r.z,sz2)*clamp(dot(pa,ba),0.,1.);
    vec2 h0=vec2(max(q-r.z,0.),p.z+s.z);
    vec2 h1=vec2(max(q,0.),p.z-s.z);
    
    return sqrt(min(dot(diag,diag),min(dot(h0,h0),dot(h1,h1))))
    *sign(max(dot(pa,vec2(-ba.y,ba.x)),d.z))-r.y;
}

float sdUberprim(vec3 p,vec4 s,vec3 r){
    // these operations can be precomputed
    s.xy-=r.x;
    r.x-=s.w;
    s.w-=r.y;
    s.z-=r.y;
    vec2 ba=vec2(r.z,-2.*s.z);
    return sdUnterprim(p,s,r,ba/dot(ba,ba),ba.y);
}