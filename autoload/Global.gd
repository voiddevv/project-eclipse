extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	Save.load()
	Engine.max_fps = Save.get_data("prefs","fps",240)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _notification(what):
	match what:
		NOTIFICATION_APPLICATION_FOCUS_OUT:
			RenderingServer.render_loop_enabled = false
			get_tree().paused = true
		NOTIFICATION_APPLICATION_FOCUS_IN:
			RenderingServer.render_loop_enabled = true
			get_tree().paused = false
