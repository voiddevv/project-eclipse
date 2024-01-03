extends Node2D
@export var handle_input:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var pressed:Array[bool] = [false,false,false,false]
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
var note_actions:PackedStringArray = ["note_left","note_down","note_up","note_right"]
func get_dir_from_event(ev:InputEvent):
	for i in note_actions:
		if ev.is_action(i): return note_actions.find(i)
	return -1

func _unhandled_input(event):
	var dir:int = get_dir_from_event(event)
	if dir == -1: return
	pressed[dir] = event.is_pressed()
	if pressed[dir]:
		get_child(dir).scale *= Vector2(0.7,0.7)
	if not pressed[dir]:
		get_child(dir).scale /= Vector2(0.7,0.7)
	get_viewport().set_input_as_handled()
	
func _physics_process(delta):
	pass
