extends Node2D

var chart:Chart
var bpm_index:int = 0
@onready var strums = $"HUD Layer/HUD/strums"
@onready var tracks = $tracks

# Called when the node enters the scene tree for the first time.
func _ready():
	Conductor.bar_hit.connect(bar_hit)
	chart = Chart.load_chart("crystallized","hard.json")
	Conductor.bpm = chart.initial_bpm
	load_tracks()
func load_tracks():
	var song_path:String = "res://songs/%s/tracks/" %chart.song_name
	
	var files:PackedStringArray = DirAccess.get_files_at(song_path)
	for file in files:
		if file.ends_with(".import"):
			print(file.replace(".import",""))
			var stream:AudioStream = load(song_path + file.replace(".import",""))
			var player:AudioStreamPlayer = AudioStreamPlayer.new()
			player.stream = stream
			tracks.add_child(player)
			player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	Conductor.time += delta
	
func check_bpm_chnage():
	for k in chart.bpms.keys():
		if chart.bpms.keys().find(k) < bpm_index: continue
		if Conductor.time >= k:
			bpm_index += 1
			Conductor.bpm = chart.bpms.get(k)
			print("BPM CHANGE")
func _physics_process(delta):
	check_bpm_chnage()
func bar_hit(bar:int):
	pass
