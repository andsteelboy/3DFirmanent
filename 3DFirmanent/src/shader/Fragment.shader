#version 330 core

out vec4 FragColor;
in vec2 TexCoord;
in vec3 FragPos;
in vec3 Normal;

uniform vec3 viewPos;

struct Material {
    sampler2D diffuse;
    sampler2D specular;
    float shininess;
};

struct SpotLight {  // Matches C++ usage
    vec3 position;
    vec3 direction;
    float cutOff;    // Matches C++ (capital 'O')
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float constant;
    float linearVal; // Matches C++
    float quadratic; // Matches C++
};
uniform SpotLight spotLight;  // Exact match to C++ name
uniform Material material;

void main()
{
    // Spotlight calculations
    vec3 lightDir = normalize(spotLight.position - FragPos);
    float theta = dot(lightDir, normalize(-spotLight.direction));

    if (theta > spotLight.cutOff)
    {
        // Attenuation
        float distance = length(spotLight.position - FragPos);
        float attenuation = 1.0 / (spotLight.constant + spotLight.linearVal * distance +
            spotLight.quadratic * (distance * distance));

        // Ambient
        vec3 ambient = spotLight.ambient * vec3(texture(material.diffuse, TexCoord));
        ambient = attenuation*ambient;

        // Diffuse 
        vec3 norm = normalize(Normal);
        float diff = max(dot(norm, lightDir), 0.0);
        vec3 diffuse = spotLight.diffuse * diff * vec3(texture(material.diffuse, TexCoord));
        diffuse = attenuation*diffuse;

        // Specular
        vec3 viewDir = normalize(viewPos - FragPos);
        vec3 reflectDir = reflect(-lightDir, norm);
        float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
        vec3 specular = spotLight.specular * spec * vec3(texture(material.specular, TexCoord));
        specular = attenuation*specular;

        // Combine results
        vec3 result = ambient + diffuse + specular;
        FragColor = vec4(result , 1.0f);
    }
    else
    {
        // Outside the spotlight cutoff - just show ambient light
        FragColor = vec4(spotLight.ambient * vec3(texture(material.diffuse, TexCoord)), 1.0);
    }
}