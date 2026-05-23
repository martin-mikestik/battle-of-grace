shader_type canvas_item;

uniform float strength : hint_range(0.0, 5.0) = 4.0;
uniform int iterations : hint_range(1, 15) = 8;

float gaussian(float x, float sigma) {
    return exp(-(x * x) / (2.0 * sigma * sigma)) / (sqrt(2.0 * 3.14159) * sigma);
}

void fragment() {
    vec2 uv = UV;
    float blurred_alpha = 0.0;
    float total_weight = 0.0;
    float sigma = strength;

    for (int i = -iterations; i <= iterations; i++) {
        for (int j = -iterations; j <= iterations; j++) {
            vec2 offset = vec2(float(i), float(j)) * TEXTURE_PIXEL_SIZE;
            float weight = gaussian(float(i), sigma) * gaussian(float(j), sigma);
            
            // We ONLY care about the alpha channel from the source
            blurred_alpha += texture(TEXTURE, uv + offset).a * weight;
            total_weight += weight;
        }
    }

    float final_alpha = blurred_alpha / total_weight;
    
    // 1. Start with PURE WHITE (or whatever color you want the blur to be)
    vec3 color_pure = vec3(1.0, 1.0, 1.0);
    
    // 2. Assign the color and the alpha.
    // To prevent the "dark halo," we do NOT multiply by alpha here 
    // IF the CanvasItemMaterial is set to 'Mix'. 
    // Godot's default 'Mix' mode expects straight alpha.
    COLOR = vec4(color_pure, final_alpha);
}