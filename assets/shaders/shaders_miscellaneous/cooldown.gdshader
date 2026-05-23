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
	
	float radians_uncovered = radians(degrees_uncovered);
	
	float current_pixel_radians = atan(normalized.y, normalized.x);
	float my_degrees = degrees(current_pixel_radians);

	if (my_degrees < 0.0) {
        my_degrees += 360.0;
    }
	
	vec4 current_color = texture(TEXTURE, UV);
	vec4 final_color = (1.0 - degree_of_shade) * current_color + degree_of_shade * vec4(0.0, 0.0, 0.0, 1.0);
	if (my_degrees > degrees_uncovered) {
		final_color.a = current_color.a;
		COLOR = final_color;
	}

}
