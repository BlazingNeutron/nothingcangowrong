shader_type canvas_item;

uniform sampler2D dissolve_pattern;
uniform float dissolve_state : hint_range(0.0, 1.1) = 0;

void fragment() {
	float pattern_val = texture(dissolve_pattern, UV).r;
	COLOR.rgba = vec4(0.1, 0.1, 0.1, 0.8 - step(dissolve_state, pattern_val));
}