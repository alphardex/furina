/*
A function to read DepthTexture.
Ref: https://threejs.org/examples/webgl_depth_texture
*/

float readDepth(sampler2D depthSampler,vec2 coord){
    float fragCoordZ=texture(depthSampler,coord).x;
    float viewZ=perspectiveDepthToViewZ(fragCoordZ,cameraNear,cameraFar);
    return viewZToOrthographicDepth(viewZ,cameraNear,cameraFar);
}