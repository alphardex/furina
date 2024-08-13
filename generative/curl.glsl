/*
Ref: https://gist.github.com/Samsy/ce0802c2dbded8511fda
*/

vec4 mod289(vec4 x){
    return x-floor(x*(1./289.))*289.;
}

float mod289(float x){
    return x-floor(x*(1./289.))*289.;
}

vec4 permute(vec4 x){
    return mod289(((x*34.)+1.)*x);
}

float permute(float x){
    return mod289(((x*34.)+1.)*x);
}

vec4 taylorInvSqrt(vec4 r){
    return 1.79284291400159-.85373472095314*r;
}

float taylorInvSqrt(float r){
    return 1.79284291400159-.85373472095314*r;
}

vec4 grad4(float j,vec4 ip){
    const vec4 ones=vec4(1.,1.,1.,-1.);
    vec4 p,s;
    p.xyz=floor(fract(vec3(j)*ip.xyz)*7.)*ip.z-1.;p.w=1.5-dot(abs(p.xyz),ones.xyz);
    s=vec4(lessThan(p,vec4(0.)));
    p.xyz=p.xyz+(s.xyz*2.-1.)*s.www;
    return p;
}

#define F4.309016994374947451

vec4 simplexNoiseDerivatives(vec4 v){
    const vec4 C=vec4(.138196601125011,.276393202250021,.414589803375032,-.447213595499958);
    vec4 i=floor(v+dot(v,vec4(F4)));
    vec4 x0=v-i+dot(i,C.xxxx);
    vec4 i0;
    vec3 isX=step(x0.yzw,x0.xxx);
    vec3 isYZ=step(x0.zww,x0.yyz);
    i0.x=isX.x+isX.y+isX.z;i0.yzw=1.-isX;
    i0.y+=isYZ.x+isYZ.y;i0.zw+=1.-isYZ.xy;
    i0.z+=isYZ.z;
    i0.w+=1.-isYZ.z;
    vec4 i3=clamp(i0,0.,1.);
    vec4 i2=clamp(i0-1.,0.,1.);
    vec4 i1=clamp(i0-2.,0.,1.);
    vec4 x1=x0-i1+C.xxxx;
    vec4 x2=x0-i2+C.yyyy;
    vec4 x3=x0-i3+C.zzzz;
    vec4 x4=x0+C.wwww;
    i=mod289(i);
    float j0=permute(permute(permute(permute(i.w)+i.z)+i.y)+i.x);
    vec4 j1=permute(permute(permute(permute(i.w+vec4(i1.w,i2.w,i3.w,1.))+i.z+vec4(i1.z,i2.z,i3.z,1.))+i.y+vec4(i1.y,i2.y,i3.y,1.))+i.x+vec4(i1.x,i2.x,i3.x,1.));vec4 ip=vec4(1./294.,1./49.,1./7.,0.);
    vec4 p0=grad4(j0,ip);
    vec4 p1=grad4(j1.x,ip);
    vec4 p2=grad4(j1.y,ip);
    vec4 p3=grad4(j1.z,ip);
    vec4 p4=grad4(j1.w,ip);
    vec4 norm=taylorInvSqrt(vec4(dot(p0,p0),dot(p1,p1),dot(p2,p2),dot(p3,p3)));
    p0*=norm.x;
    p1*=norm.y;
    p2*=norm.z;
    p3*=norm.w;
    p4*=taylorInvSqrt(dot(p4,p4));
    vec3 values0=vec3(dot(p0,x0),dot(p1,x1),dot(p2,x2));
    vec2 values1=vec2(dot(p3,x3),dot(p4,x4));
    vec3 m0=max(.5-vec3(dot(x0,x0),dot(x1,x1),dot(x2,x2)),0.);
    vec2 m1=max(.5-vec2(dot(x3,x3),dot(x4,x4)),0.);
    vec3 temp0=-6.*m0*m0*values0;
    vec2 temp1=-6.*m1*m1*values1;
    vec3 mmm0=m0*m0*m0;
    vec2 mmm1=m1*m1*m1;
    float dx=temp0[0]*x0.x+temp0[1]*x1.x+temp0[2]*x2.x+temp1[0]*x3.x+temp1[1]*x4.x+mmm0[0]*p0.x+mmm0[1]*p1.x+mmm0[2]*p2.x+mmm1[0]*p3.x+mmm1[1]*p4.x;
    float dy=temp0[0]*x0.y+temp0[1]*x1.y+temp0[2]*x2.y+temp1[0]*x3.y+temp1[1]*x4.y+mmm0[0]*p0.y+mmm0[1]*p1.y+mmm0[2]*p2.y+mmm1[0]*p3.y+mmm1[1]*p4.y;
    float dz=temp0[0]*x0.z+temp0[1]*x1.z+temp0[2]*x2.z+temp1[0]*x3.z+temp1[1]*x4.z+mmm0[0]*p0.z+mmm0[1]*p1.z+mmm0[2]*p2.z+mmm1[0]*p3.z+mmm1[1]*p4.z;
    float dw=temp0[0]*x0.w+temp0[1]*x1.w+temp0[2]*x2.w+temp1[0]*x3.w+temp1[1]*x4.w+mmm0[0]*p0.w+mmm0[1]*p1.w+mmm0[2]*p2.w+mmm1[0]*p3.w+mmm1[1]*p4.w;
    return vec4(dx,dy,dz,dw)*49.;
}

vec3 curl(in vec3 p,in float noiseTime,in float persistence){
    vec4 xNoisePotentialDerivatives=vec4(0.);
    vec4 yNoisePotentialDerivatives=vec4(0.);
    vec4 zNoisePotentialDerivatives=vec4(0.);
    for(int i=0;i<2;++i){
        float twoPowI=pow(2.,float(i));
        float scale=.5*twoPowI*pow(persistence,float(i));
        xNoisePotentialDerivatives+=simplexNoiseDerivatives(vec4(p*twoPowI,noiseTime))*scale;
        yNoisePotentialDerivatives+=simplexNoiseDerivatives(vec4((p+vec3(123.4,129845.6,-1239.1))*twoPowI,noiseTime))*scale;
        zNoisePotentialDerivatives+=simplexNoiseDerivatives(vec4((p+vec3(-9519.,9051.,-123.))*twoPowI,noiseTime))*scale;
    }
    return vec3(zNoisePotentialDerivatives[1]-yNoisePotentialDerivatives[2],xNoisePotentialDerivatives[2]-zNoisePotentialDerivatives[0],yNoisePotentialDerivatives[0]-xNoisePotentialDerivatives[1]);
}