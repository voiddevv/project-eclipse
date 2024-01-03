shader_type canvas_item;
uniform sampler2D tex:hint_default_black;
void fragment() {
	COLOR = (texture(tex,UV) - sin(TIME + texture(TEXTURE,UV))) + distance(vec2(0.5),UV);
	// Called for every pixel the material is visible on.
}