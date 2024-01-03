extends Node2D
@onready var label = $CanvasLayer/Label
var time:float = 0.0
func _physics_process(delta):
	time += delta
	if time >= 1.0:
		label.text = "FPS:%s\nVRAM:%s\nSRAM:%s"%[Engine.get_frames_per_second(),String.humanize_size(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED)),String.humanize_size(OS.get_static_memory_usage())]
