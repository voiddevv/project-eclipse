class_name StrumLine extends Node2D
@export var handle_input:bool = false
@onready var receptors = $receptors
@onready var note_group:NoteGroup = $NoteGroup
# Called when the node enters the scene tree for the first time.
func _ready():
	Input.use_accumulated_input = false
	for i:Receptor in receptors.get_children():
		if i.material:
			i.material = i.material.duplicate()

var pressed:Array[bool] = [false,false,false,false]

var note_actions:PackedStringArray = ["note_left","note_down","note_up","note_right"]

func get_dir_from_event(ev:InputEvent):
	for i in note_actions:
		if ev.is_action(i): return note_actions.find(i)
	return -1

func _unhandled_input(event):
	var dir:int = get_dir_from_event(event)
	if dir == -1 or not handle_input: return
	if event.pressed and not pressed[dir]:
		var receptor:Receptor = receptors.get_child(dir)
		receptor.play("press")
		receptor.material.set_shader_parameter("enable",true)
		pressed[dir] = true
		
		# note input shit
		var notes:Array = note_group.get_children().filter(func(_note): return _note.can_hit and _note.data.direction == dir) if not note_group.get_children().is_empty() else []
		notes.sort_custom(func(a:Note,b:Note): return a.data.hit_time < b.data.hit_time)
		if notes.is_empty(): return
		receptor.play("confirm")
		notes[0].queue_free()

	if not event.pressed and pressed[dir]:
		var receptor:Receptor = receptors.get_child(dir)
		receptor.play("static")
		receptor.material.set_shader_parameter("enable",false)
		pressed[dir] = false
	
	get_viewport().set_input_as_handled()
	
