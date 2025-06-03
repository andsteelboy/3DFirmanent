#version 330 core
out vec4 FragColor;
in vec4 vertexColor;
in vec2 TexCoord;

uniform sampler2D texture1;
uniform sampler2D texture2;

void main()
{
    // Mix the two textures (50% each)
    vec3 texColor = mix(
        texture(texture1, TexCoord).rgb,
        texture(texture2, TexCoord).rgb,
        0.1
    );

    // Fake "lighting" using texture coordinates (cheap trick)
    float light = max(TexCoord.x + TexCoord.y, 0.3); // Brightens diagonally

    // Apply to texture
    FragColor = vec4(texColor * light, 1.0);
}