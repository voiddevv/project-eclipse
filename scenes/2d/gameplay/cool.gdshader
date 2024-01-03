shader_type canvas_item;
uniform int divides = 8;
void fragment() {
	vec2 uv = UV;
	COLOR.r = texture(TEXTURE,vec2(uv.x+0.07,uv.y)).r;
	// Called for every pixel the material is visible on.
}
