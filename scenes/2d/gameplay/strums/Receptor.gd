class_name Receptor extends AnimatedSprite2D
enum {
	STATIC = 1,
	PRESSED = 2,
	CONFIRM = 3
}
var cur_state:int = STATIC
@export var direction:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
