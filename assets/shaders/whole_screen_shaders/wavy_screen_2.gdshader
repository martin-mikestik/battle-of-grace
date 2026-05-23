shader_type canvas_item;

// Grab the screen content
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;

// Parameters you can tweak in the Inspector
uniform float wave_speed : hint_range(0.0, 10.0) = 3.0;
uniform float wave_frequency : hint_range(0.0, 50.0) = 15.0;
uniform float wave_amplitude : hint_range(0.0, 0.1) = 0.01;
uniform vec4 tint_color : source_color = vec4(0.8, 0.4, 0.4, 0.2);

void fragment() {
	// Calculate the distortion
	vec2 uv = SCREEN_UV;
	
	// Create a wave offset using sine functions
	// We use TIME to animate and UV to vary the effect across the screen
	float wave = sin(uv.y * wave_frequency + TIME * wave_speed) * wave_amplitude;
	float wave_x = cos(uv.x * wave_frequency + TIME * wave_speed) * wave_amplitude;
	
	// Apply the offset to the UV coordinates
	vec2 distorted_uv = vec2(uv.x + wave, uv.y + wave_x);
	
	// Sample the screen at the new distorted position
	vec4 screen_color = texture(screen_texture, distorted_uv);
	
	// Mix with a blueish tint for that "underwater" look
	vec4 final_color = mix(screen_color, tint_color, tint_color.a);
COLOR = vec4(final_color.rgb, 1.0); // Force alpha to 1.0
}