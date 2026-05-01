shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float degrees_uncovered = 60.0;
const float shade_of_grey = 0.001;
const float degree_of_shade = 0.6;

void fragment() {
	// Called for every pixel the material is visible on.
	
	// x goes left -> right
	// y goes up - > down
	
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
	
	float my_degrees = (360.0 / (2.0 * PI)) * current_pixel_radians;
	vec4 current_color = texture(TEXTURE, UV);
	if (my_degrees > degrees_uncovered) {
		vec4 final_color2 = (1.0 - degree_of_shade) * current_color + degree_of_shade * vec4(0.0, 0.0, 0.0, 1.0);
		vec4 second_color = vec4(shade_of_grey, shade_of_grey, shade_of_grey, 1.0);
		vec4 final_color = (current_color + second_color) / 2.0;
		final_color2.a = current_color.a;
		COLOR = final_color2;
		
	}
	//
	//if (UV.x >= 0.9 && UV.y >= 0.9) {
		//COLOR = vec4(1.0, 0.0, 0.0, 1.0);
	//}

	// COLOR = vec4(1.0, 0.0, 0.0, 1.0); // solid red
}
