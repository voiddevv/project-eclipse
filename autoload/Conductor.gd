extends Node

#signals
signal beat_hit(beat:int)
signal step_hit(step:int)
signal bar_hit(bar:int)

var time:float = 0.0
var bpm:float = 100.0
# float shit
var beatf:float = 0.0
var barf:float = 0.0
var stepf:float = 0.0
#int stuff
var beati:int = 0:
	get: return floori(beatf)
var bari:float = 0:
	get: return floori(barf)
var stepi:float = 0:
	get: return floori(stepf)
	
var crochet:float:
	get:
		return 60.0/bpm
		
var step_crochet:float:
	get:
		return crochet*0.25
		
var bar_crochet:float:
	get:
		return crochet*4.0
		
var last_time:float = 0.0

func _process(delta):
	var dt:float = time - last_time
	var _last_beat:int = beati
	var _last_step:int = stepi
	var _last_bar:int = bari
	var _beat_delta:float = (bpm/60.0) * dt
	beatf += _beat_delta
	stepf += _beat_delta*4.0
	barf += _beat_delta/4.0
	last_time = time
	if _last_beat != beati: beat_hit.emit(beati)
	if _last_step != stepi: step_hit.emit(stepi)
	if _last_bar != bari: bar_hit.emit(bari)
