shader_type canvas_item;



uniform float degrees_uncovered = 60.0;
uniform float max_distance_affected = 15;
uniform vec4 regular_color = vec4(0.8, 0.1, 0.1, 1.0);

void fragment() {
	// Called for every pixel the material is visible on.

	
	float shifted_x = (UV.x - 0.5) * 2.0;
	float shifted_y = (UV.y - 0.5) * -2.0;
	
	vec2 not_normalized = vec2(shifted_x, shifted_y);
	vec2 normalized = normalize(not_normalized);
	
	float my_sin = sin(normalized.y);
	float my_cos = cos(normalized.x);
	

	float radians_uncovered = degrees_uncovered * ( 2.0 * PI / 360.0);
	
	float current_pixel_radians = 0.0;
	float alpha = asin(normalized.y);
	
	if (normalized.y >= 0.0 && normalized.x >= 0.0) {
		current_pixel_radians = alpha;
	} else if (normalized.y >= 0.0 && normalized.x <= 0.0) {
		current_pixel_radians = PI - alpha;
	} else if (normalized.y <= 0.0 && normalized.x >= 0.0) {
		current_pixel_radians = 2.0 * PI - alpha;
	} else {
		current_pixel_radians = PI + alpha;
	}
	
	float current_pixel_degrees = current_pixel_radians * (360.0 / (2.0 * PI));
	
	float distance_degrees = abs(degrees_uncovered - current_pixel_degrees);
	
	if (distance_degrees <= max_distance_affected) {
		float percentage = distance_degrees / max_distance_affected;
		COLOR = regular_color;
		COLOR.a = percentage;
	} else {
		COLOR = regular_color;
	}
	
}
