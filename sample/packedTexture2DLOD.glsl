// With original size argument
vec4 packedTexture2DLOD(sampler2D tex,vec2 uv,int level,vec2 originalPixelSize){
    float floatLevel=float(level);
    vec2 atlasSize;
    atlasSize.x=floor(originalPixelSize.x*1.5);
    atlasSize.y=originalPixelSize.y;
    // we stop making mip maps when one dimension == 1
    float maxLevel=min(floor(log2(originalPixelSize.x)),floor(log2(originalPixelSize.y)));
    floatLevel=min(floatLevel,maxLevel);
    // use inverse pow of 2 to simulate right bit shift operator
    vec2 currentPixelDimensions=floor(originalPixelSize/pow(2.,floatLevel));
    vec2 pixelOffset=vec2(
        floatLevel>0.?originalPixelSize.x:0.,
        floatLevel>0.?currentPixelDimensions.y:0.
    );
    // "minPixel / atlasSize" samples the top left piece of the first pixel
    // "maxPixel / atlasSize" samples the bottom right piece of the last pixel
    vec2 minPixel=pixelOffset;
    vec2 maxPixel=pixelOffset+currentPixelDimensions;
    vec2 samplePoint=mix(minPixel,maxPixel,uv);
    samplePoint/=atlasSize;
    vec2 halfPixelSize=1./(2.*atlasSize);
    samplePoint=min(samplePoint,maxPixel/atlasSize-halfPixelSize);
    samplePoint=max(samplePoint,minPixel/atlasSize+halfPixelSize);
    return sampleBicubic(tex,samplePoint,originalPixelSize);
}

vec4 packedTexture2DLOD(sampler2D tex,vec2 uv,float level,vec2 originalPixelSize){
    float ratio=mod(level,1.);
    int minLevel=int(floor(level));
    int maxLevel=int(ceil(level));
    vec4 minValue=packedTexture2DLOD(tex,uv,minLevel,originalPixelSize);
    vec4 maxValue=packedTexture2DLOD(tex,uv,maxLevel,originalPixelSize);
    return mix(minValue,maxValue,ratio);
}