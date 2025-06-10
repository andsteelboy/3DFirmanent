#version 330 core

out vec4 FragColor;
in vec2 TexCoord;
in vec3 FragPos;
in vec3 Normal;



uniform vec3 lightPos;
uniform vec3 viewPos;

struct Material {
    vec3 ambient;
    sampler2D specular;
    sampler2D diffuse;
    float shininess;
};
struct Light {
    vec3 direction;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
};
uniform Material material;
uniform Light light;


void main()
{
    

    // Ambient
    vec3 ambient =  vec3(texture(material.diffuse, TexCoord)) * light.ambient;

    // Diffuse 
    vec3 norm = normalize(Normal);
    vec3 lightDir = normalize(-light.direction);
    float diff = max(dot(norm, lightDir), 0.0);
    vec3 diffuse = diff * vec3(texture(material.diffuse,TexCoord)) * light.diffuse;

    // Specular (Blinn-Phong optimization)
    vec3 viewDir = normalize(viewPos - FragPos);
    vec3 halfwayDir = normalize(lightDir + viewDir);  // Faster than reflect()
    float spec = pow(max(dot(norm, halfwayDir), 0.0), material.shininess);
    vec3 specular = spec * vec3(texture(material.specular,TexCoord)) * light.specular;

    // Combine (objectColor affects only diffuse/ambient)
    vec3 result = (ambient + diffuse+specular);
    FragColor = vec4(result, 1.0);
}