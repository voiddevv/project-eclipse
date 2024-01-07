extends CanvasLayer

@onready var label:Label = $Label
var time:float = 0.0

func _ready() -> void:
	_update()

func _physics_process(delta:float) -> void:
	time += delta
	
	if time >= 1.0:
		_update()

func _update() -> void:
	var sram:String = String.humanize_size(OS.get_static_memory_usage())
	var vram:String = String.humanize_size(Performance.get_monitor(Performance.RENDER_VIDEO_MEM_USED))
	var fps:float = Engine.get_frames_per_second()
	label.text = "FPS:%s\nVRAM:%s\nSRAM:%s"%[fps,vram,sram]
