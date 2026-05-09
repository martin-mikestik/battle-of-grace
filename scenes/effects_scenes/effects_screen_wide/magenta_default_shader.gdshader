shader_type canvas_item;

// Grab the screen content
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

// Control how strong the magenta effect is (0.0 to 1.0)
uniform float intensity : hint_range(0.0, 1.0) = 0.3;

void fragment() {
    // 1. Get the original screen color at the current pixel
    vec4 screen_color = texture(screen_texture, SCREEN_UV);
    
    // 2. Define our target Magenta (Full Red, No Green, Full Blue)
    vec3 magenta = vec3(1.0, 0.0, 1.0);
    
    // 3. Mix the original color with magenta based on the intensity
    vec3 final_rgb = mix(screen_color.rgb, magenta, intensity);
    
    // 4. Output the result
    COLOR = vec4(final_rgb, 1.0);
}