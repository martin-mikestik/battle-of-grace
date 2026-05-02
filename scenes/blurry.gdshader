shader_type canvas_item;

uniform float strength : hint_range(0.0, 20.0) = 4.0;
uniform int iterations : hint_range(1, 55) = 8;

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
            
            // Only sample the ALPHA channel
            blurred_alpha += texture(TEXTURE, uv + offset).a * weight;
            total_weight += weight;
        }
    }

    float final_alpha = blurred_alpha / total_weight;
    
    // Force the color to be pure white, using the blurred alpha
    COLOR = vec4(1.0, 1.0, 1.0, final_alpha);
}