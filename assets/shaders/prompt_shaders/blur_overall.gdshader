shader_type canvas_item;

// Grab the screen content
// Note: blur requires mipmaps to look smooth at high strength
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

// Parameters you can tweak in the Inspector
// blur_strength: 0.0 is sharp, higher values are blurrier
uniform float blur_strength : hint_range(0.0, 10.0) = 4.0; 
// quality: higher number = smoother blur but much heavier on performance (3 to 6 is usually good)
uniform int quality : hint_range(1, 10) = 4;
// tint_color: optional dark/bright/colored overlay
uniform vec4 tint_color : source_color = vec4(0.0, 0.0, 0.0, 0.3);

void fragment() {
	// The core idea is to sample many points around the current pixel
	// and average their colors.
	
	vec2 uv = SCREEN_UV;
	
	// Convert the strength variable (which is pixels) into UV units
	// textureSize gets the original screen size
	vec2 pixel_size = 1.0 / vec2(textureSize(screen_texture, 0));
	vec2 blur_size = blur_strength * pixel_size;
	
	vec3 blurred_color = vec3(0.0);
	float weight_total = 0.0;
	
	// Create a grid of samples
	// The wider the grid (higher quality/strength), the smoother the blur
	for(int x = -quality; x <= quality; x++) {
		for(int y = -quality; y <= quality; y++) {
			// Offset the sampling point
			vec2 offset = vec2(float(x), float(y)) * blur_size;
			
			// Sample the screen at the offset position
			vec3 sample = texture(screen_texture, uv + offset).rgb;
			
			// Use simple box filtering, meaning every sample gets equal weight
			blurred_color += sample;
			weight_total += 1.0;
		}
	}
	
	// Average the collected colors
	blurred_color /= weight_total;
	
	// Mix with a tint overlay
	vec3 final_color = mix(blurred_color, tint_color.rgb, tint_color.a);
	
	// Ensure the alpha is solid for a full-screen effect
	COLOR = vec4(final_color, 1.0);
}