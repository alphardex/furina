/*
Ref: https://scrapbox.io/0b5vr/Cyclic_Noise
*/

mat3 getOrthogonalBasis(vec3 z){
    z=normalize(z);
    vec3 up=abs(z.y)<.99?vec3(0.,1.,0.):vec3(0.,0.,1.);
    vec3 x=normalize(cross(up,z));
    return mat3(x,cross(z,x),z);
}

vec3 cyclicNoise(vec3 p,float pump){
    vec4 sum=vec4(0.);
    mat3 basis=getOrthogonalBasis(vec3(-1.,2.,-3.));
    
    for(int i=0;i<5;i++){
        p*=basis;
        p+=sin(p.yzx);
        sum+=vec4(
            cross(cos(p),sin(p.zxy)),
            1.
        );
        sum*=pump;
        p*=2.;
    }
    
    return sum.xyz/sum.w;
}