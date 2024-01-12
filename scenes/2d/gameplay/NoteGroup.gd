## Note Handling 
class_name NoteGroup extends Node2D
## strumline that all notes are connected to in the group
@onready var strumline:StrumLine = $"../"
## position of notes to override default behavour
var override_position:Vector2 = Vector2.ZERO
## position offset of all notes in the group
@onready var note_position_offset:Vector2 = Vector2.ZERO
## note rotation offset in degress for all notes in group
@onready var note_rotation_offset:float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update_notes()

	pass

## updates all notes in the group
func update_notes():
	for note:Note in get_children():
		var receptor:Receptor = strumline.receptors.get_child(note.data.duplicate().direction%4)
		
		note.global_position.y = note_position_offset.y + strumline.position.y - (note.data.hit_time - Conductor.time)*450*3.2
		
		note.rotation_degrees = note_rotation_offset + receptor.rotation_degrees
		note.position.x = note_position_offset.x + receptor.position.x
		if override_position.x != 0: note.position.x = override_position.x
		if override_position.y != 0: note.position.y = override_position.y
		if Conductor.time - note.data.hit_time >= 0 and not strumline.handle_input:
			receptor.play("confirm")
			note.visible = false
			if not receptor.animation_finished.is_connected(receptor.play.bind("static")):
				receptor.animation_finished.connect(receptor.play.bind("static"),CONNECT_ONE_SHOT)
			note.queue_free()
			continue
		if note.too_late:
			note.queue_free()

