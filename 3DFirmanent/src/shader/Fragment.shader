#version 330 core
out vec4 FragColor;
in vec4 vertexColor;
in vec2 TexCoord;
in vec3 FragPos;
in vec3 Normal;

uniform sampler2D texture1;
uniform sampler2D texture2;

uniform vec3 objectColor;
uniform vec3 lightColor;
uniform vec3 lightPos;

void main()
{
    float ambientStrength = 0.4f;
    vec3 ambientColor = ambientStrength * lightColor;
    vec3 normal = normalize(Normal);
    vec3 lightDir = normalize(lightPos-FragPos);
    float diffuse = max(dot(normal, lightDir), 0.0f);
    vec3 diffuseColor = diffuse * lightColor;
    vec3 result = (ambientColor+diffuseColor) * objectColor;
    FragColor = vec4(result, 1.0);
}