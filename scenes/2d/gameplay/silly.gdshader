shader_type canvas_item;

void vertex() {
	if(VERTEX.y <= 0.0){
	VERTEX.x += sin(TIME + VERTEX.y*32.0) * VERTEX.y/5.0;
	}
}

void fragment() {
	// Called for every pixel the material is visible on.
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
