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

struct Material {
    vec3 ambient;
    vec3 specular;
    vec3 diffuse;
    float shininess;
};
uniform Material material;


void main()
{
    float ambientStrength = 0.4;
    float specularStrength = 0.5;  // Now actually used!

    // Ambient
    vec3 ambient = ambientStrength * material.ambient * lightColor;

    // Diffuse 
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(lightPos - FragPos);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * material.diffuse * lightColor;

    // Specular (Blinn-Phong optimization)
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 halfwayDir = normalize(lightDir + viewDir);  // Faster than reflect()
    float spec = pow(max(dot(norm, halfwayDir), 0.0), material.shininess);
    vec3 specular = specularStrength * spec * material.specular * lightColor;

    // Combine (objectColor affects only diffuse/ambient)
    vec3 result = (ambient + diffuse) * objectColor + specular;
    FragColor = vec4(result, 1.0);
}