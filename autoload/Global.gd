extends Node

var display_dpi:int = DisplayServer.screen_get_dpi(DisplayServer.SCREEN_OF_MAIN_WINDOW)
var main_window:Window:
	get:
		return get_window()
# Called when the node enters the scene tree for the first time.
func check_settings() -> void:
	Save.load()
	Engine.max_fps = Save.get_data("graphics","fps",240)
	DisplayServer.window_set_vsync_mode(Save.get_data("graphics","vsync_mode",0))

	
func _ready():
	check_settings()
	print(DisplayServer.window_get_vsync_mode(DisplayServer.MAIN_WINDOW_ID))
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
