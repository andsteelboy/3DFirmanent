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
uniform vec3 viewPos;


void main()
{
    float ambientStrength = 0.4f;
    float specularStrength = 0.5;

    vec3 ambientColor = ambientStrength * lightColor;

    vec3 normal = normalize(Normal);
    vec3 lightDir = normalize(lightPos-FragPos);
    vec3 viewDirection = normalize(viewPos - FragPos);
    vec3 lightReflection = reflect(-lightDir, normal);

    float diffuse = max(dot(normal, lightDir), 0.0f);
    vec3 diffuseColor = diffuse * lightColor;
    float spec = pow(max(dot(viewDirection, lightReflection), 0.0), 32);
    vec3 specular = specularStrength * spec * lightColor;

    vec3 result = (ambientColor+diffuseColor+specular) * objectColor;
    FragColor = vec4(result, 1.0);
}