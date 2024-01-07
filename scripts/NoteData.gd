class_name NoteData extends Resource

@export var strum_id:int
@export var direction:int
@export var sustain_length:float
@export var hit_time:float
@export var type:String
func _to_string():
	return "strum_id:%s"%strum_id
