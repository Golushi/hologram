uniform float uTime;

varying vec3 vPosition;
varying vec3 vNormal;

#include ../includes/random2D.glsl

void main()
{
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // Glitch 
    float glitchTime = uTime - (modelPosition.y * 0.70);
    float glitchStrength = sin(glitchTime) + sin(glitchTime * 3.45) + sin(glitchTime * 8.76);
    glitchStrength /= 3.5;
    glitchStrength = smoothstep(0.2, 0.8, glitchStrength);
    glitchStrength *= 0.20;
    modelPosition.x += (random2D(modelPosition.xz + uTime) - 0.5) * (glitchStrength * 0.8);
    modelPosition.z += (random2D(modelPosition.zx + uTime) - 0.5) * (glitchStrength * 0.8);

    // Final position
    gl_Position = projectionMatrix * viewMatrix * modelPosition;

    // Model normal
    vec4 modelNormal = modelMatrix * vec4(normal, 0.0);

    // Varying
    vPosition = modelPosition.xyz;
    vNormal = modelNormal.xyz;
}